import { useState } from 'react'
import { fn } from 'storybook/test'
import SituationSelect from './SituationSelect.jsx'

/** O campo é controlado: a story guarda o valor e repassa cada mudança ao painel Actions */
function ControlledSituationSelect(args) {
  const [value, setValue] = useState(args.value)

  function handleChange(situation) {
    setValue(situation)
    args.onChange(situation)
  }

  return <SituationSelect {...args} value={value} onChange={handleChange} />
}

/** Origem no Delphi: `cbxFilterSituation` de Gerenciar movimentações e de Gráficos */
export default {
  title: 'Controles/SituationSelect',
  component: SituationSelect,
  render: ControlledSituationSelect,
  args: {
    value: null,
    onChange: fn()
  }
}

/** Padrão ao abrir as duas telas: "Todas" */
export const Default = {}
