import { useId } from 'react'
import FormField from '../FormField/FormField.jsx'

/**
 * Campo de data com rótulo (no Delphi, `TLabel` + `TDateTimePicker`). O valor é uma string
 * `'YYYY-MM-DD'`, o mesmo formato gravado no banco (skill tipos-legado-delphi). O navegador
 * mostra a data no formato do sistema (DD/MM/AAAA em pt-BR).
 *
 * O `TDateTimePicker` sempre tem uma data. Aqui o usuário pode apagar o campo, e então
 * `onChange` recebe `''`; a tela decide o que fazer (decidido em 24/10/2026). A data padrão
 * (hoje, hoje − 30 dias…) também fica com a tela.
 *
 * @param {{
 *   label: string,
 *   value: string,
 *   onChange?: (value: string, event: import('react').ChangeEvent<HTMLInputElement>) => void,
 *   id?: string,
 *   className?: string
 * } & Omit<import('react').InputHTMLAttributes<HTMLInputElement>, 'onChange' | 'value' | 'type'>} props
 */
export default function DateField({ label, value, onChange, id, className = '', ...props }) {
  const generatedId = useId()
  const inputId = id ?? generatedId

  return (
    <FormField label={label} htmlFor={inputId} className={className}>
      <input
        id={inputId}
        type="date"
        className="form-field-control"
        value={value}
        onChange={(event) => onChange?.(event.target.value, event)}
        {...props}
      />
    </FormField>
  )
}
