import { useState } from 'react'
import { fn } from 'storybook/test'
import MoneyField from './MoneyField.jsx'

/** O campo é controlado: a story guarda os centavos, mostra o valor e o repassa ao painel Actions */
function ControlledMoneyField(args) {
  const [value, setValue] = useState(args.value)

  function handleChange(cents) {
    setValue(cents)
    args.onChange(cents)
  }

  return (
    <div style={{ display: 'grid', gap: 'var(--space-sm)' }}>
      <MoneyField {...args} value={value} onChange={handleChange} />
      <output>Valor em centavos: {value === null ? 'null' : value}</output>
    </div>
  )
}

/**
 * Origem no Delphi: `edtInstallmentesValue` de `fMovement` (RN-25). Experimente digitar
 * `1500`, sair do campo (vira `1.500,00`), voltar e sair de novo: o valor se mantém (D-12).
 */
export default {
  title: 'Controles/MoneyField',
  component: MoneyField,
  render: ControlledMoneyField,
  args: {
    label: 'Valor das parcelas',
    value: null,
    onChange: fn()
  }
}

export const Default = {}

/** Valor carregado do banco: Gerenciar movimentações, "R$ Valor" */
export const WithValue = {
  args: { label: 'R$ Valor', value: 150000 }
}
