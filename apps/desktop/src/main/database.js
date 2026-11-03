import { join } from 'path'
import { app } from 'electron'
import { is } from '@electron-toolkit/utils'
import Database from 'better-sqlite3'

const DATABASE_NAME = 'PersonalFinancialControl'

/** @type {import('better-sqlite3').Database | null} */
let connection = null

/**
 * Em desenvolvimento, usa a cópia criada por `npm run db:dev-copy`, nunca o banco
 * do Delphi em `database/`. Empacotado, usa a pasta de dados do usuário.
 */
function databasePath() {
  const folder = is.dev ? join(app.getAppPath(), 'dev-data') : app.getPath('userData')
  return join(folder, DATABASE_NAME)
}

/**
 * Abre a conexão única com o banco. Chamar uma vez, depois de `app.whenReady()`.
 *
 * @returns {string} caminho do arquivo aberto
 * @throws se o arquivo não existir: o banco nunca é criado vazio aqui
 */
export function openDatabase() {
  const path = databasePath()
  connection = new Database(path, { fileMustExist: true })
  // O better-sqlite3 liga a verificação de FK por padrão. O legado roda com ela desligada,
  // e ligar mudaria o resultado das exclusões (D-14) e rejeitaria os registros órfãos.
  connection.pragma('foreign_keys = OFF')
  return path
}

/**
 * Conexão aberta, para uso exclusivo do processo principal.
 *
 * @returns {import('better-sqlite3').Database}
 */
export function getDatabase() {
  if (connection === null) {
    throw new Error('Banco de dados não está aberto: chame openDatabase() antes.')
  }
  return connection
}

export function closeDatabase() {
  connection?.close()
  connection = null
}
