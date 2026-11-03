import FormField from './FormField.jsx'

/**
 * Origem no Delphi: `TLabel` branco logo acima do campo, em todos os formulários de cadastro.
 * Os campos já o usam; aqui ele aparece com um controle qualquer.
 */
export default {
  title: 'Controles/FormField',
  component: FormField,
  args: {
    label: 'Situação',
    htmlFor: 'form-field-story'
  },
  render: (args) => (
    <FormField {...args}>
      <select id={args.htmlFor} defaultValue="Todas">
        <option>Todas</option>
        <option>Não Pagas</option>
        <option>Pagas</option>
      </select>
    </FormField>
  )
}

export const Default = {}
