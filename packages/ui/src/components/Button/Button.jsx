import './Button.css'

/**
 * Botão de ação no padrão visual do sistema (no Delphi, `TPanel` com hover via
 * `TFunctions.SetButtonColors`). Aqui o hover e o foco são feitos por CSS.
 * As demais props (`onClick`, `disabled`, `aria-label`…) vão direto para o `<button>`.
 *
 * `size`: `md` é o botão de 41 px das barras de cadastro; `lg` é o de 46–51 px de `fMovement`
 * (Salvar, Cancelar e "Gerar Parcelas").
 *
 * @param {{ type?: 'button' | 'submit' | 'reset', size?: 'md' | 'lg', className?: string, children: import('react').ReactNode } & import('react').ButtonHTMLAttributes<HTMLButtonElement>} props
 */
export default function Button({
  type = 'button',
  size = 'md',
  className = '',
  children,
  ...props
}) {
  const classes = ['button', size === 'lg' && 'button-lg', className].filter(Boolean).join(' ')
  return (
    <button type={type} className={classes} {...props}>
      {children}
    </button>
  )
}
