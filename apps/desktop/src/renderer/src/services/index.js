/**
 * Implementações dos contratos de @pfc/ui/services para o desktop.
 * Cada serviço chama o processo principal via IPC (window.api, exposto pelo preload).
 *
 * @returns {import('@pfc/ui/services/ServicesContext.js').Services}
 */
export function createServices() {
  return {
    category: {
      list: () => window.api.category.list()
    }
  }
}
