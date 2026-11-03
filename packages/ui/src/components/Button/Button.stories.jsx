import { fn } from 'storybook/test'
import Button from './Button.jsx'

/** Origem no Delphi: `TPanel` com hover via `TFunctions.SetButtonColors` (SCREENS.md §3.5.1) */
export default {
  title: 'Controles/Button',
  component: Button,
  args: {
    children: 'Salvar',
    onClick: fn()
  },
  argTypes: {
    size: { control: 'inline-radio', options: ['md', 'lg'] }
  }
}

export const Default = {}

/** Salvar/Cancelar e "Gerar Parcelas" do Cadastro de Receitas / Despesas */
export const Large = {
  args: { size: 'lg', children: 'Gerar Parcelas' }
}

export const Disabled = {
  args: { disabled: true }
}
