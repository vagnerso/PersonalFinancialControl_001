// Acesso a dados de Categorias (TCategory, class/uCategory.pas).
// TODO(migração): implementar via IPC (processo principal + SQLite, driver a definir), com SQL parametrizado.
// Este arquivo é um STUB da sandbox: guarda categorias fictícias em memória e não acessa o banco.

import { newUniqueId } from '../../domain/legacy-types.js';

let nextId = 1;
const categories = ['Alimentação', 'Moradia', 'Transporte', 'saúde', 'Lazer', 'Educação', 'Salário'].map((name) => ({
  id: nextId++,
  uniqueId: newUniqueId(),
  name,
}));

// Só na sandbox: um nome igual a este faz o stub falhar, para testar o caminho de erro (D-04).
const SANDBOX_FAILING_NAME = '#erro';

// SQLite LIKE: % e _ são curingas; maiúsculas/minúsculas iguais só para letras sem acento.
function lowerAscii(text) {
  return text.replace(/[A-Z]/g, (letter) => letter.toLowerCase());
}

function likeContains(value, text) {
  const pattern = Array.from(lowerAscii(`%${text}%`))
    .map((char) => {
      if (char === '%') return '.*';
      if (char === '_') return '.';
      return char.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
    })
    .join('');
  return new RegExp(`^${pattern}$`, 'su').test(lowerAscii(value));
}

/**
 * TCategory.Search (RN-15): filtra pelo nome com LIKE '%texto%' e ordena por nome decrescente.
 * Texto só com espaços não filtra (Length(Trim(...)) > 0 no Delphi).
 * TODO(migração): no main process, `WHERE NAME LIKE ?` com o parâmetro `%texto%` e `ORDER BY NAME DESC`.
 * @returns {Promise<Array<{ id: number, uniqueId: string, name: string }>>}
 */
export async function searchCategories(text) {
  const filtered = text.trim().length > 0
    ? categories.filter((category) => likeContains(category.name, text))
    : categories;
  return filtered
    .map((category) => ({ ...category }))
    .sort((a, b) => (a.name < b.name ? 1 : a.name > b.name ? -1 : 0));
}

/**
 * TCategory.InsertRegister: gera UNIQUE_ID novo e grava o nome sem validação (RN-17).
 * TODO(migração): RN-04 pendente: gravar ID_USER do usuário logado, obtido no main process.
 */
export async function insertCategory({ name }) {
  if (name === SANDBOX_FAILING_NAME) throw new Error('Falha simulada da sandbox');
  categories.push({ id: nextId++, uniqueId: newUniqueId(), name });
}

/** TCategory.UpdateRegister: altera o nome pelo UNIQUE_ID. Um UNIQUE_ID inexistente não altera nada. */
export async function updateCategory({ uniqueId, name }) {
  if (name === SANDBOX_FAILING_NAME) throw new Error('Falha simulada da sandbox');
  const category = categories.find((item) => item.uniqueId === uniqueId);
  if (category) category.name = name;
}

/**
 * TCategory.DeleteRegister: exclusão definitiva pelo UNIQUE_ID (RN-16).
 * D-14 (decisão: Manter, 12/10/2026): não verifica se há subcategorias ligadas.
 */
export async function deleteCategory(uniqueId) {
  const index = categories.findIndex((item) => item.uniqueId === uniqueId);
  if (index >= 0 && categories[index].name === SANDBOX_FAILING_NAME) throw new Error('Falha simulada da sandbox');
  if (index >= 0) categories.splice(index, 1);
}
