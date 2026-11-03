/**
 * Contrato do serviço de Categorias: chave `category` do objeto `Services`.
 *
 * @typedef {Object} Category
 * @property {number} id
 * @property {string} name
 *
 * @typedef {Object} CategoryService
 * @property {() => Promise<Category[]>} list Todas as categorias, ordenadas pelo nome de Z a A, como no Delphi
 */

export {}
