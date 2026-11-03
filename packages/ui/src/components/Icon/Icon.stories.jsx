import Icon from './Icon.jsx'
import { iconNames } from './icons.js'

/** Origem no Delphi: `TImage` com PNG embutido no `.dfm`. Os ícones são brancos */
export default {
  title: 'Controles/Icon',
  component: Icon,
  args: { name: 'search' },
  argTypes: {
    name: { control: 'select', options: iconNames }
  }
}

export const Default = {}

export const All = {
  render: () => (
    <div style={{ display: 'flex', gap: 'var(--space-xl)' }}>
      {iconNames.map((name) => (
        <figure key={name} style={{ margin: 0, textAlign: 'center' }}>
          <Icon name={name} />
          <figcaption>{name}</figcaption>
        </figure>
      ))}
    </div>
  )
}
