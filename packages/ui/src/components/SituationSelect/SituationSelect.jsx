import Select from '../Select/Select.jsx'

/**
 * Os valores são os de `MOVEMENT.SITUATION` (0 = Não pago, 1 = Pago), e `null` = sem
 * filtro. No Delphi, o filtro guarda `ItemIndex - 1` (-1, 0 ou 1).
 *
 * Os textos são os de Gerenciar movimentações também em Gráficos, que no Delphi mostra
 * "Não Pagos / Pagos" (unificado em 24/10/2026).
 */
const OPTIONS = [
  { value: null, label: 'Todas' },
  { value: 0, label: 'Não Pagas' },
  { value: 1, label: 'Pagas' }
]

/**
 * Filtro de situação de Gerenciar movimentações e de Gráficos (no Delphi,
 * `cbxFilterSituation`, padrão "Todas"). É só lista: o texto não é editável, embora o
 * `TComboBox` do Delphi não seja `csDropDownList` (decidido em 24/10/2026).
 *
 * @param {{
 *   value: 0 | 1 | null,
 *   onChange?: (value: 0 | 1 | null) => void,
 *   label?: string
 * } & Omit<import('react').SelectHTMLAttributes<HTMLSelectElement>, 'onChange' | 'value'>} props
 */
export default function SituationSelect({ value, onChange, label = 'Situação', ...props }) {
  return <Select label={label} options={OPTIONS} value={value} onChange={onChange} {...props} />
}
