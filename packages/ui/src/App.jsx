import './styles/index.css'
import './App.css'
import { ServicesProvider } from './services/ServicesProvider.jsx'
import CategoryList from './screens/CategoryList/CategoryList.jsx'

/**
 * Componente raiz, montado pelo desktop e pela web.
 * Cada aplicação passa em `services` as suas implementações de acesso a dados.
 *
 * A navegação entre telas (rotas, menu) ainda está a definir; por enquanto, mostra direto
 * a listagem provisória de categorias.
 *
 * @param {{ services: import('./services/ServicesContext.js').Services }} props
 */
export default function App({ services }) {
  return (
    <ServicesProvider services={services}>
      <div className="app">
        <header className="app-title">Personal Financial Control</header>
        <main className="app-content">
          <CategoryList />
        </main>
      </div>
    </ServicesProvider>
  )
}
