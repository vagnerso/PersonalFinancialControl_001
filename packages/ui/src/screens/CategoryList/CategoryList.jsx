import './CategoryList.css'
import { useEffect, useState } from 'react'
import { useServices } from '../../services/ServicesContext.js'

/**
 * Tela PROVISÓRIA: só valida a conexão com o banco, para comparar a listagem com a grade do
 * Delphi (`fCategory`). Não é a conversão da tela: não tem pesquisa, inclusão, alteração nem exclusão.
 */
export default function CategoryList() {
  const { category } = useServices()
  const [categories, setCategories] = useState(null)
  const [error, setError] = useState(null)

  useEffect(() => {
    let ignore = false
    category.list().then(
      (rows) => {
        if (!ignore) setCategories(rows)
      },
      (reason) => {
        if (!ignore) setError(reason.message)
      }
    )
    return () => {
      ignore = true
    }
  }, [category])

  if (error) {
    return <p className="category-list-message">Erro ao tentar listar as categorias: {error}</p>
  }

  if (categories === null) {
    return <p className="category-list-message">Carregando…</p>
  }

  return (
    <section className="category-list">
      <h1 className="category-list-title">Categorias (tela provisória)</h1>
      <table className="category-list-grid">
        <thead>
          <tr>
            <th>Nome</th>
          </tr>
        </thead>
        <tbody>
          {categories.map(({ id, name }) => (
            <tr key={id}>
              <td>{name}</td>
            </tr>
          ))}
        </tbody>
      </table>
      <p className="category-list-message">Total de registros: {categories.length}</p>
    </section>
  )
}
