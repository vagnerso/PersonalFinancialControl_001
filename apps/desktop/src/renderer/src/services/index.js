/**
 * Implementações dos contratos de @pfc/ui/services para o desktop.
 * Cada serviço chamará o processo principal via IPC (window.api, exposto pelo preload).
 *
 * @returns {import('@pfc/ui/services/ServicesContext.js').Services}
 */
export function createServices() {
  // TODO(migração): implementar os serviços quando o driver SQLite for definido
  return {}
}
