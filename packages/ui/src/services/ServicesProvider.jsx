import { ServicesContext } from './ServicesContext.js'

/**
 * Disponibiliza para as telas as implementações de serviço da aplicação.
 *
 * @param {{ services: import('./ServicesContext.js').Services, children: import('react').ReactNode }} props
 */
export function ServicesProvider({ services, children }) {
  return <ServicesContext.Provider value={services}>{children}</ServicesContext.Provider>
}
