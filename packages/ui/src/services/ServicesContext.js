import { createContext, useContext } from 'react'

/**
 * Serviços de acesso a dados fornecidos por cada aplicação (desktop via IPC, web a definir).
 * Cada contrato `<entidade>Service.js` desta pasta documenta uma chave deste objeto
 * (ex.: `category`), com funções que retornam Promise.
 *
 * @typedef {Object} Services
 */

/** @type {import('react').Context<Services | null>} */
export const ServicesContext = createContext(null)

/**
 * Devolve os serviços fornecidos pelo `ServicesProvider` da aplicação.
 * Uso nas telas: `const { category } = useServices()`.
 *
 * @returns {Services}
 */
export function useServices() {
  const services = useContext(ServicesContext)
  if (services === null) {
    throw new Error('useServices() precisa ser usado dentro de <ServicesProvider>.')
  }
  return services
}
