import { useId, useState } from 'react'
import { formatMoney, parseMoneyInput } from '@pfc/domain/legacy-types'
import FormField from '../FormField/FormField.jsx'
import { applyFilter } from '../FormField/applyFilter.js'

const DECIMAL_SEPARATOR = ','

/** Texto → centavos. A vírgula no fim ('12,') é a digitação em andamento, não um erro */
const toCents = (text) => parseMoneyInput(text.replace(/,$/, ''))

const toText = (cents) => (cents === null || cents === undefined ? '' : formatMoney(cents))

/** Colagem: mantém só dígitos, pontos e a primeira vírgula */
function sanitize(text) {
  const allowed = text.replace(/[^\d.,]/g, '')
  const first = allowed.indexOf(DECIMAL_SEPARATOR)
  if (first === -1) return allowed
  return allowed.slice(0, first + 1) + allowed.slice(first + 1).replaceAll(DECIMAL_SEPARATOR, '')
}

/**
 * Campo de valor monetário com rótulo (no Delphi, o `TEdit` "Valor das parcelas" de
 * `fMovement`, com `OnKeyPress` e `OnExit` próprios). Segue a RN-25:
 * - aceita só dígitos e **um** separador decimal; `.` e `,` digitados viram `,`;
 * - ao sair do campo, formata como `#,##0.00` (`1.500,00`); texto vazio ou inválido vira `0,00`.
 *
 * O valor é em **centavos inteiros** (skill tipos-legado-delphi). `onChange` recebe os
 * centavos a cada mudança (`null` enquanto o texto não é um valor válido) e, ao sair do
 * campo, o valor final, nunca `null`.
 *
 * A conversão usa `parseMoneyInput`, que aceita o separador de milhar que o próprio campo
 * coloca ao formatar. Assim, sair do campo de novo não perde o valor (D-12 corrigida,
 * decidido em 24/10/2026). Também é usado em "R$ Valor" de Gerenciar movimentações, que no
 * Delphi é um `TEdit` comum (decidido em 24/10/2026).
 *
 * @param {{
 *   label: string,
 *   value: number | null,
 *   onChange?: (cents: number | null) => void,
 *   id?: string,
 *   className?: string
 * } & Omit<import('react').InputHTMLAttributes<HTMLInputElement>, 'onChange' | 'value' | 'type'>} props
 */
export default function MoneyField({
  label,
  value,
  onChange,
  onKeyDown,
  onBlur,
  id,
  className = '',
  ...props
}) {
  const generatedId = useId()
  const inputId = id ?? generatedId
  const [text, setText] = useState(() => toText(value))
  const [previousValue, setPreviousValue] = useState(value)

  // Valor trocado por fora (ex.: a tela carregou outro registro): reescreve o texto.
  // Quando é o eco do que o próprio campo enviou, o texto digitado fica como está
  if (value !== previousValue) {
    setPreviousValue(value)
    if (value !== toCents(text)) setText(toText(value))
  }

  function updateText(nextText) {
    setText(nextText)
    onChange?.(toCents(nextText))
  }

  function handleKeyDown(event) {
    onKeyDown?.(event)
    const { key } = event
    if (
      event.defaultPrevented ||
      key.length !== 1 ||
      event.ctrlKey ||
      event.metaKey ||
      event.altKey
    ) {
      return
    }

    if (/\d/.test(key)) return
    event.preventDefault()
    if (key !== '.' && key !== DECIMAL_SEPARATOR) return

    // Separador: só um por campo (fora do trecho selecionado, que será substituído)
    const input = event.currentTarget
    const start = input.selectionStart ?? input.value.length
    const end = input.selectionEnd ?? start
    const outside = input.value.slice(0, start) + input.value.slice(end)
    if (outside.includes(DECIMAL_SEPARATOR)) return

    const nextText = input.value.slice(0, start) + DECIMAL_SEPARATOR + input.value.slice(end)
    input.value = nextText
    input.setSelectionRange(start + 1, start + 1)
    updateText(nextText)
  }

  function handleChange(event) {
    updateText(applyFilter(event.target, sanitize))
  }

  function handleBlur(event) {
    const cents = toCents(text) ?? 0
    setText(formatMoney(cents))
    onChange?.(cents)
    onBlur?.(event)
  }

  return (
    <FormField label={label} htmlFor={inputId} className={className}>
      <input
        id={inputId}
        type="text"
        inputMode="decimal"
        className="form-field-control"
        value={text}
        onKeyDown={handleKeyDown}
        onChange={handleChange}
        onBlur={handleBlur}
        {...props}
      />
    </FormField>
  )
}
