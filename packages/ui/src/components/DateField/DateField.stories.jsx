import { useState } from 'react'
import { fn } from 'storybook/test'
import DateField from './DateField.jsx'

/** O campo é controlado: a story guarda o valor e repassa cada mudança ao painel Actions */
function ControlledDateField(args) {
  const [value, setValue] = useState(args.value)

  function handleChange(text, event) {
    setValue(text)
    args.onChange(text, event)
  }

  return <DateField {...args} value={value} onChange={handleChange} />
}

/** Origem no Delphi: `TLabel` + `TDateTimePicker` */
export default {
  title: 'Controles/DateField',
  component: DateField,
  render: ControlledDateField,
  args: {
    label: 'Data de vencimento',
    value: '2026-10-24',
    onChange: fn()
  }
}

export const Default = {}

/** Campo apagado pelo usuário: `onChange` recebe `''` */
export const Empty = {
  args: { value: '' }
}
