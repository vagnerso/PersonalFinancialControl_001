import { fn } from 'storybook/test'
import IconButton from './IconButton.jsx'

/** Origem no Delphi: `TImage` 30×30 com `OnClick` e `Hint` (pesquisa e lookups) */
export default {
  title: 'Controles/IconButton',
  component: IconButton,
  args: { onClick: fn() }
}

/** imButtonSearchExecute / imButtonSearch… */
export const Search = {
  args: { icon: 'search', label: 'Clique aqui para executar a pesquisa' }
}

/** imButtonClearEdtSearch / imButtonClearEdt… */
export const Clear = {
  args: { icon: 'clear', label: 'Clique aqui para limpar o campo de pesquisa' }
}

/** Ordem do Delphi: o limpar fica à esquerda da lupa */
export const ClearAndSearch = {
  render: (args) => (
    <div style={{ display: 'flex', gap: 'var(--space-sm)' }}>
      <IconButton {...args} icon="clear" label="Clique aqui para limpar o campo de pesquisa" />
      <IconButton {...args} icon="search" label="Clique aqui para executar a pesquisa" />
    </div>
  )
}
