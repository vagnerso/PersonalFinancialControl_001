import './FormField.css'

/**
 * Rótulo acima do campo, como nos formulários do Delphi (`TLabel` branco logo acima do
 * `TEdit`, `TComboBox` ou `TDateTimePicker`). Os campos (TextField…) já o usam; use-o
 * direto só para um controle que ainda não tenha componente próprio.
 *
 * @param {{ label: string, htmlFor: string, className?: string, children: import('react').ReactNode }} props
 */
export default function FormField({ label, htmlFor, className = '', children }) {
  return (
    <div className={`form-field ${className}`.trim()}>
      <label htmlFor={htmlFor} className="form-field-label">
        {label}
      </label>
      {children}
    </div>
  )
}
