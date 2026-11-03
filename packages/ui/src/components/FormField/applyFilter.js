/**
 * Aplica o filtro direto no campo e devolve o texto filtrado. Mexer no DOM antes do
 * `onChange` evita dois problemas do campo controlado: o cursor pular para o fim quando
 * o texto muda, e o caractere recusado continuar na tela quando o valor não muda.
 * Usado pelos campos que filtram o que é digitado ou colado (TextField, MoneyField).
 *
 * @param {HTMLInputElement} input
 * @param {(text: string) => string} filter
 */
export function applyFilter(input, filter) {
  const raw = input.value
  const filtered = filter(raw)
  if (filtered !== raw) {
    const caret = filter(raw.slice(0, input.selectionStart ?? raw.length)).length
    input.value = filtered
    input.setSelectionRange(caret, caret)
  }
  return filtered
}
