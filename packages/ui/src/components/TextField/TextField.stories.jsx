import { useState } from 'react'
import { fn } from 'storybook/test'
import TextField from './TextField.jsx'

/** O campo é controlado: a story guarda o valor e repassa cada mudança ao painel Actions */
function ControlledTextField(args) {
  const [value, setValue] = useState(args.value)

  function handleChange(text, event) {
    setValue(text)
    args.onChange(text, event)
  }

  return <TextField {...args} value={value} onChange={handleChange} />
}

/**
 * Origem no Delphi: `TLabel` + `TEdit`. Cobre também os campos de senha (`PasswordChar`)
 * e só de números (`NumbersOnly`) do mapeamento.
 */
export default {
  title: 'Controles/TextField',
  component: TextField,
  render: ControlledTextField,
  args: {
    label: 'Descrição da conta',
    value: '',
    onChange: fn()
  }
}

export const Default = {}

/** `TextHint` do Delphi */
export const WithPlaceholder = {
  args: {
    label: 'Pesquisar',
    placeholder: 'Digite aqui o que deseja pesquisar'
  }
}

/** Login e Usuários (`PasswordChar = '*'`) */
export const Password = {
  args: { label: 'Senha', type: 'password' }
}

/** Código da Cidade e Nº máximo de parcelas (`NumbersOnly = True`) */
export const NumbersOnly = {
  args: { label: 'Código', numbersOnly: true }
}

/** E-mail, Endereço, Número, Bairro e Cidade de Fornecedores/Clientes (`CharCase = ecLowerCase`) */
export const Lowercase = {
  args: { label: 'E-mail', lowercase: true }
}
