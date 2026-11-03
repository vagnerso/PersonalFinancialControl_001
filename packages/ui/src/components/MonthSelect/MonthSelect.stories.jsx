import { useState } from 'react'
import { fn } from 'storybook/test'
import MonthSelect from './MonthSelect.jsx'

/** O campo é controlado: a story guarda o valor e repassa cada mudança ao painel Actions */
function ControlledMonthSelect(args) {
  const [value, setValue] = useState(args.value)

  function handleChange(month) {
    setValue(month)
    args.onChange(month)
  }

  return <MonthSelect {...args} value={value} onChange={handleChange} />
}

/** Origem no Delphi: `cbxFilterMonth` (Gerenciar) e `cbxFilterMonthOrYear` no modo "Mês" (Gráficos) */
export default {
  title: 'Controles/MonthSelect',
  component: MonthSelect,
  render: ControlledMonthSelect,
  args: {
    value: 10,
    onChange: fn()
  }
}

/** Gráficos: só os 12 meses */
export const Default = {}

/** Gerenciar movimentações: "Todos" + os 12 meses */
export const IncludeAll = {
  args: { includeAll: true }
}
