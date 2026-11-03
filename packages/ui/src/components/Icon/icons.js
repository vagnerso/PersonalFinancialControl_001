import searchIcon from '../../assets/icons/search.png'
import clearIcon from '../../assets/icons/clear.png'
import settingsIcon from '../../assets/icons/settings.png'

/**
 * Imagens extraídas do `Picture.Data` dos `.dfm` (não são os arquivos de `images/`, que
 * têm versões parecidas, mas não iguais). Todas são brancas, para o fundo escuro do tema.
 */
export const ICONS = {
  // imButtonSearchExecute e imButtonSearch… (24×24): lupa da pesquisa e dos lookups
  search: searchIcon,
  // imButtonClearEdt… (24×24): limpar a pesquisa e os lookups
  clear: clearIcon,
  // imgButtonUtilities de fMain (48×48): engrenagem que abre Utilitários
  settings: settingsIcon
}

/** @typedef {keyof typeof ICONS} IconName */

export const iconNames = Object.keys(ICONS)
