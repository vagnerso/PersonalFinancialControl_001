import './IconButton.css'
import Icon from '../Icon/Icon.jsx'

/**
 * Ícone clicável, como a lupa e o limpar ao lado dos campos (no Delphi, `TImage` com
 * `OnClick`, `Hint` e cursor de mão). `label` é a dica do Delphi: aparece ao passar o
 * mouse (`title`) e é o nome do botão para leitores de tela.
 *
 * No Delphi, o `TImage` não recebe foco. Aqui o botão entra na ordem do Tab, para o lookup
 * abrir pelo teclado em todas as telas (decidido em 24/10/2026). Como no Delphi, não muda
 * de aparência com o mouse em cima.
 *
 * @param {{ icon: import('../Icon/icons.js').IconName, label: string, className?: string } & Omit<import('react').ButtonHTMLAttributes<HTMLButtonElement>, 'children'>} props
 */
export default function IconButton({ icon, label, className = '', ...props }) {
  return (
    <button
      type="button"
      className={`icon-button ${className}`.trim()}
      title={label}
      aria-label={label}
      {...props}
    >
      <Icon name={icon} />
    </button>
  )
}
