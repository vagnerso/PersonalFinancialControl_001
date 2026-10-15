// Conversões entre os tipos gravados pelo sistema Delphi (SQLite) e JavaScript.
// Referência: .claude/skills/tipos-legado-delphi/SKILL.md e docs/DATABASE.md §3.
// Copie para packages/domain/src/legacy-types.js na primeira vez que for necessário.

// ---------------------------------------------------------------- Datas
// O banco guarda datas como texto 'YYYY-MM-DD', sem hora (ex.: MOVEMENT.ISSUE_DATE).
// Trabalhe com a string; só crie Date quando precisar de aritmética, sempre em horário local.

const ISO_DATE = /^(\d{4})-(\d{2})-(\d{2})$/;

/** Data "zero" do Delphi (TDateTime = 0), gravada quando nenhuma data foi informada (D-05). */
export const DELPHI_ZERO_DATE = '1899-12-30';

/** Valida uma data 'YYYY-MM-DD' que existe no calendário. */
export function isIsoDate(value) {
  const m = ISO_DATE.exec(value ?? '');
  if (!m) return false;
  const [y, mo, d] = [Number(m[1]), Number(m[2]), Number(m[3])];
  return mo >= 1 && mo <= 12 && d >= 1 && d <= daysInMonth(y, mo);
}

/** Lê ISSUE_DATE do banco. Retorna null para vazio, inválido ou data zero do Delphi. */
export function fromDbDate(value) {
  if (!isIsoDate(value) || value === DELPHI_ZERO_DATE) return null;
  return value;
}

/** 'YYYY-MM-DD' → 'DD/MM/AAAA' (exibição, RN-60). */
export function isoToBr(iso) {
  const m = ISO_DATE.exec(iso ?? '');
  return m ? `${m[3]}/${m[2]}/${m[1]}` : '';
}

/** 'DD/MM/AAAA' → 'YYYY-MM-DD'. Retorna null se inválida. */
export function brToIso(br) {
  const m = /^(\d{2})\/(\d{2})\/(\d{4})$/.exec(br ?? '');
  if (!m) return null;
  const iso = `${m[3]}-${m[2]}-${m[1]}`;
  return isIsoDate(iso) ? iso : null;
}

/** Data local de hoje em 'YYYY-MM-DD'. Não use toISOString(): ele converte para UTC. */
export function todayIso(now = new Date()) {
  return [now.getFullYear(), pad2(now.getMonth() + 1), pad2(now.getDate())].join('-');
}

export const yearOf = (iso) => Number(iso.slice(0, 4));
export const monthOf = (iso) => Number(iso.slice(5, 7));

/**
 * Soma meses com a semântica do IncMonth do Delphi: se o dia não existe
 * no mês de destino, usa o último dia desse mês (31/01 + 1 → 28/02).
 */
export function addMonths(iso, months) {
  const m = ISO_DATE.exec(iso);
  if (!m) throw new Error(`Data inválida: ${iso}`);
  const total = Number(m[1]) * 12 + (Number(m[2]) - 1) + months;
  const year = Math.floor(total / 12);
  const month = (total % 12) + 1;
  const day = Math.min(Number(m[3]), daysInMonth(year, month));
  return `${year}-${pad2(month)}-${pad2(day)}`;
}

function daysInMonth(year, month) {
  return new Date(year, month, 0).getDate();
}

function pad2(n) {
  return String(n).padStart(2, '0');
}

// ---------------------------------------------------------------- Dinheiro
// O banco guarda valores em DOUBLE (MOVEMENT.INSTALLMENT_VALUE), todos com até 2 casas.
// Em JS, converta para centavos inteiros na entrada e só volte para reais ao gravar/exibir.

/** Valor do banco (reais, float) → centavos inteiros. */
export function toCents(dbValue) {
  return Math.round((Number(dbValue) || 0) * 100);
}

/** Centavos → valor para gravar no banco (reais), enquanto o esquema usar DOUBLE. */
export function centsToDb(cents) {
  return cents / 100;
}

/** Centavos → '1.234,56'. Com { symbol: true } → 'R$ 1.234,56' (RN-60). */
export function formatMoney(cents, { symbol = false } = {}) {
  const text = new Intl.NumberFormat('pt-BR', {
    minimumFractionDigits: 2,
    maximumFractionDigits: 2,
  }).format(cents / 100);
  return symbol ? `R$ ${text}` : text;
}

/**
 * Texto digitado → centavos. Retorna null se inválido (RN-25 trata inválido como 0:
 * quem chama decide).
 * Com vírgula: '.' é milhar e ',' é decimal ('1.500,25').
 * Sem vírgula: '.' é decimal, como no campo Delphi, que converte '.' em ',' (RN-25).
 */
export function parseMoneyInput(text) {
  let s = String(text ?? '').replace(/R\$|\s/g, '');
  if (s === '') return null;
  if (s.includes(',')) s = s.replace(/\./g, '').replace(',', '.');
  if (!/^-?\d+(\.\d{1,2})?$/.test(s)) return null;
  const [int, dec = ''] = s.replace('-', '').split('.');
  const cents = Number(int) * 100 + Number(dec.padEnd(2, '0'));
  return s.startsWith('-') ? -cents : cents;
}

// ---------------------------------------------------------------- Booleanos
// SQLite não tem boolean: o banco usa INTEGER 0/1 (TYPE_PAYMENT.ALLOWS_INSTALLMENT).

/** 0/1 do banco → boolean. NULL vira false. Outros valores são erro, como no Delphi (IntegerToBoolean). */
export function fromDbBool(value) {
  if (value === null || value === undefined || value === 0) return false;
  if (value === 1) return true;
  throw new Error(`Valor booleano inválido no banco: ${value}`);
}

/** boolean → 0/1. Não envie true/false ao driver SQLite. */
export function toDbBool(value) {
  return value ? 1 : 0;
}

// ---------------------------------------------------------------- Ligações (IDs)
// "Sem ligação" foi gravado como 0, às vezes como '' (PERSON.ID_CITY), nunca como NULL.

/** ID de ligação lido do banco → número ou null quando vazio (0, '', null). */
export function fromDbFk(value) {
  if (value === null || value === undefined || value === '' || Number(value) === 0) return null;
  return Number(value);
}

/** ID de ligação para gravar. Mantém o 0 do legado enquanto o esquema não mudar. */
export function toDbFk(id) {
  return id ?? 0;
}

// ---------------------------------------------------------------- Identificadores

/** Novo UNIQUE_ID no formato do Delphi: UUID em maiúsculas, sem chaves. */
export function newUniqueId() {
  return crypto.randomUUID().toUpperCase();
}
