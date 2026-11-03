import { useState } from 'react'
import { fn } from 'storybook/test'
import Select from './Select.jsx'

/** O campo é controlado: a story guarda o valor e repassa cada mudança ao painel Actions */
function ControlledSelect(args) {
  const [value, setValue] = useState(args.value)

  function handleChange(option, event) {
    setValue(option)
    args.onChange(option, event)
  }

  return <Select {...args} value={value} onChange={handleChange} />
}

/** Origem no Delphi: `TLabel` + `TComboBox` (`Style = csDropDownList`) */
export default {
  title: 'Controles/Select',
  component: Select,
  render: ControlledSelect,
  args: { onChange: fn() }
}

/** Tipos de Pagamento: "Permite parcelamento" (padrão Não) */
export const Default = {
  args: {
    label: 'Permite parcelamento',
    value: 0,
    options: [
      { value: 0, label: 'Não' },
      { value: 1, label: 'Sim' }
    ]
  }
}

/**
 * Formas de Pagamento: "Tipo de pagamento", carregado do cadastro, com IDs numéricos.
 * Nada escolhido ao incluir (`ItemIndex = -1`, ver D-13). Os nomes são só de exemplo.
 */
export const WithPlaceholder = {
  args: {
    label: 'Tipo de pagamento',
    value: null,
    placeholder: 'Selecione',
    options: [
      { value: 1, label: 'Tipo de exemplo A' },
      { value: 2, label: 'Tipo de exemplo B' },
      { value: 3, label: 'Tipo de exemplo C' }
    ]
  }
}

/** Cidades: UF (padrão RS); aqui, só algumas das 27 */
export const ManyOptions = {
  args: {
    label: 'UF',
    value: 'RS',
    options: ['PR', 'RS', 'SC', 'SP'].map((uf) => ({ value: uf, label: uf }))
  }
}
