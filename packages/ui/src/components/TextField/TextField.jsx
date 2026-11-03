import { useId } from 'react'
import FormField from '../FormField/FormField.jsx'
import { applyFilter } from '../FormField/applyFilter.js'

const toLowerCase = (text) => text.toLowerCase()
const onlyDigits = (text) => text.replace(/\D/g, '')

/**
 * Campo de texto com rótulo (no Delphi, `TLabel` + `TEdit`). As opções seguem as
 * propriedades do `TEdit`:
 * - `lowercase`: `CharCase = ecLowerCase`, converte para minúsculas ao digitar;
 * - `numbersOnly`: `NumbersOnly = True`, aceita só dígitos;
 * - `type="password"`: `PasswordChar = '*'`.
 *
 * `onChange` recebe o texto já convertido ou filtrado (e o evento, se precisar).
 * A dica do Delphi (`TextHint`) é o `placeholder`. As demais props (`onKeyDown`, `onBlur`,
 * `autoFocus`, `maxLength`…) vão direto para o `<input>`.
 *
 * @param {{
 *   label: string,
 *   value: string,
 *   onChange?: (value: string, event: import('react').ChangeEvent<HTMLInputElement>) => void,
 *   type?: 'text' | 'password',
 *   lowercase?: boolean,
 *   numbersOnly?: boolean,
 *   id?: string,
 *   className?: string
 * } & Omit<import('react').InputHTMLAttributes<HTMLInputElement>, 'onChange' | 'value' | 'type'>} props
 */
export default function TextField({
  label,
  value,
  onChange,
  type = 'text',
  lowercase = false,
  numbersOnly = false,
  id,
  className = '',
  ...props
}) {
  const generatedId = useId()
  const inputId = id ?? generatedId

  function handleChange(event) {
    let text = event.target.value
    if (lowercase) text = applyFilter(event.target, toLowerCase)
    if (numbersOnly) text = applyFilter(event.target, onlyDigits)
    onChange?.(text, event)
  }

  return (
    <FormField label={label} htmlFor={inputId} className={className}>
      <input
        id={inputId}
        type={type}
        className="form-field-control"
        value={value}
        onChange={handleChange}
        inputMode={numbersOnly ? 'numeric' : undefined}
        {...props}
      />
    </FormField>
  )
}
