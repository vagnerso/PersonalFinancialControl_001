// Cria a cópia do banco usada pelo app em desenvolvimento (dev-data/, fora do git).
// Só lê o banco do Delphi em database/. Uma cópia existente pode ter alterações
// de teste, então só é substituída com --force.
import { copyFileSync, existsSync, mkdirSync, rmSync } from 'node:fs'
import { dirname, join } from 'node:path'
import { fileURLToPath } from 'node:url'

const DATABASE_NAME = 'PersonalFinancialControl'
const JOURNAL_NAME = `${DATABASE_NAME}-journal`

const desktopRoot = join(dirname(fileURLToPath(import.meta.url)), '..')
const sourceFolder = join(desktopRoot, '..', '..', 'database')
const targetFolder = join(desktopRoot, 'dev-data')
const target = join(targetFolder, DATABASE_NAME)

if (existsSync(target) && !process.argv.includes('--force')) {
  console.error(`A cópia já existe: ${target}\nPara substituí-la: npm run db:dev-copy -- --force`)
  process.exit(1)
}

mkdirSync(targetFolder, { recursive: true })
copyFileSync(join(sourceFolder, DATABASE_NAME), target)

// O journal acompanha o banco: se o Delphi estiver no meio de uma transação,
// é com ele que o SQLite recupera a cópia ao abri-la.
rmSync(join(targetFolder, JOURNAL_NAME), { force: true })
if (existsSync(join(sourceFolder, JOURNAL_NAME))) {
  copyFileSync(join(sourceFolder, JOURNAL_NAME), join(targetFolder, JOURNAL_NAME))
}

console.log(`Cópia criada: ${target}`)
