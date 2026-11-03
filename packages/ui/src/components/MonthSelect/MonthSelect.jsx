import Select from '../Select/Select.jsx'

// Textos do Delphi (Items.Strings dos .dfm), com a inicial maiúscula
const MONTHS = [
  'Janeiro',
  'Fevereiro',
  'Março',
  'Abril',
  'Maio',
  'Junho',
  'Julho',
  'Agosto',
  'Setembro',
  'Outubro',
  'Novembro',
  'Dezembro'
].map((label, index) => ({ value: index + 1, label }))

const ALL_MONTHS = [{ value: null, label: 'Todos' }, ...MONTHS]

/**
 * Filtro de mês (no Delphi, `cbxFilterMonth` de Gerenciar movimentações e o modo "Mês"
 * de `cbxFilterMonthOrYear` em Gráficos). O valor é o mês de 1 a 12; com `includeAll`,
 * a primeira opção é "Todos" (`null`), como em Gerenciar. Os dois abrem no mês atual,
 * definido pela tela. O filtro usa sempre o ano corrente (D-01), mas isso é da consulta,
 * não do componente.
 *
 * É só lista: o texto não é editável, embora o `TComboBox` do Delphi não seja
 * `csDropDownList` (decidido em 24/10/2026).
 *
 * @param {{
 *   value: number | null,
 *   onChange?: (value: number | null) => void,
 *   includeAll?: boolean,
 *   label?: string
 * } & Omit<import('react').SelectHTMLAttributes<HTMLSelectElement>, 'onChange' | 'value'>} props
 */
export default function MonthSelect({
  value,
  onChange,
  includeAll = false,
  label = 'Mês',
  ...props
}) {
  return (
    <Select
      label={label}
      options={includeAll ? ALL_MONTHS : MONTHS}
      value={value}
      onChange={onChange}
      {...props}
    />
  )
}
