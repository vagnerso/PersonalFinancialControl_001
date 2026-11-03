import { useId } from 'react'
import FormField from '../FormField/FormField.jsx'

/**
 * `value` pode ser `null` (ex.: "Todas" num filtro): a opção é comparada por igualdade estrita.
 * @typedef {{ value: string | number | null, label: string }} SelectOption
 */

/**
 * Lista de escolha com rótulo (no Delphi, `TLabel` + `TComboBox` com `Style = csDropDownList`).
 *
 * `onChange` recebe o `value` da opção com o tipo original: um ID numérico (`Items.Objects`
 * no Delphi) volta como número, não como texto.
 *
 * `placeholder` mostra uma opção vazia enquanto nada foi escolhido (`ItemIndex = -1`).
 * Como no `csDropDownList`, depois de escolher não dá para voltar a ela.
 *
 * @param {{
 *   label: string,
 *   options: SelectOption[],
 *   value: string | number | null,
 *   onChange?: (value: string | number | null, event: import('react').ChangeEvent<HTMLSelectElement>) => void,
 *   placeholder?: string,
 *   id?: string,
 *   className?: string
 * } & Omit<import('react').SelectHTMLAttributes<HTMLSelectElement>, 'onChange' | 'value'>} props
 */
export default function Select({
  label,
  options,
  value,
  onChange,
  placeholder,
  id,
  className = '',
  ...props
}) {
  const generatedId = useId()
  const selectId = id ?? generatedId
  const selected = options.some((option) => option.value === value) ? String(value) : ''

  function handleChange(event) {
    const option = options.find((item) => String(item.value) === event.target.value)
    if (option) onChange?.(option.value, event)
  }

  return (
    <FormField label={label} htmlFor={selectId} className={className}>
      <select
        id={selectId}
        className="form-field-control"
        value={selected}
        onChange={handleChange}
        {...props}
      >
        {(placeholder !== undefined || selected === '') && (
          <option value="" disabled>
            {placeholder ?? ''}
          </option>
        )}
        {options.map((option) => (
          <option key={String(option.value)} value={String(option.value)}>
            {option.label}
          </option>
        ))}
      </select>
    </FormField>
  )
}
