import eslint from '@electron-toolkit/eslint-config'
import eslintConfigPrettier from '@electron-toolkit/eslint-config-prettier'
import eslintPluginReact from 'eslint-plugin-react'
import eslintPluginReactHooks from 'eslint-plugin-react-hooks'
import eslintPluginReactRefresh from 'eslint-plugin-react-refresh'

// Configuração única do monorepo: vale para apps/* e packages/*.
export default [
  {
    ignores: [
      '**/node_modules',
      '**/dist',
      '**/out',
      // Fora da versão nova: arquivos das skills, experimentos e projeto Delphi
      '.claude/**',
      'sandbox/**',
      'Win32/**',
      '__history/**',
      '__recovery/**'
    ]
  },
  eslint,
  eslintPluginReact.configs.flat.recommended,
  eslintPluginReact.configs.flat['jsx-runtime'],
  {
    settings: {
      react: {
        version: 'detect'
      }
    }
  },
  {
    files: ['**/*.{js,jsx}'],
    plugins: {
      'react-hooks': eslintPluginReactHooks,
      'react-refresh': eslintPluginReactRefresh
    },
    rules: {
      ...eslintPluginReactHooks.configs.recommended.rules,
      ...eslintPluginReactRefresh.configs.vite.rules,
      // O React 19 ignora propTypes; as props são documentadas com JSDoc
      'react/prop-types': 'off'
    }
  },
  eslintConfigPrettier
]
