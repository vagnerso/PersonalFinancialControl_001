import './Icon.css'
import { ICONS } from './icons.js'

/**
 * Ícone do sistema (no Delphi, `TImage`). Sem `label`, é decorativo e os leitores de tela o
 * ignoram; com `label`, o texto vira o `alt`. Para um ícone clicável, use o IconButton.
 * Os ícones disponíveis estão em `icons.js`.
 *
 * @param {{ name: import('./icons.js').IconName, label?: string, className?: string }} props
 */
export default function Icon({ name, label, className = '' }) {
  return (
    <img
      src={ICONS[name]}
      alt={label ?? ''}
      aria-hidden={label ? undefined : true}
      className={`icon ${className}`.trim()}
      draggable={false}
    />
  )
}
