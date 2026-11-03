import { ipcMain } from 'electron'
import { getDatabase } from './database'

/** Handlers IPC do contrato `category` (@pfc/ui/services/categoryService.js). */
export function registerCategoryHandlers() {
  // Mesma ordem da grade do Delphi (TCategory.Search), de Z a A
  ipcMain.handle('category:list', () =>
    getDatabase()
      .prepare('SELECT ID, NAME FROM CATEGORY ORDER BY NAME DESC')
      .all()
      .map(({ ID, NAME }) => ({ id: ID, name: NAME }))
  )
}
