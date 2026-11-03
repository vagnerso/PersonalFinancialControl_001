// Mesmos estilos globais que o App importa: tokens, tema e base
import '../src/styles/index.css'

/** @type {import('@storybook/react-vite').Preview} */
export default {
  tags: ['autodocs'],
  parameters: {
    controls: {
      matchers: {
        color: /(background|color)$/i,
        date: /Date$/i
      }
    }
  },
  // A página Docs tem fundo branco; o fundo do app garante o contraste dos rótulos brancos
  decorators: [
    (Story) => (
      <div style={{ background: 'var(--color-app-bg)', padding: 'var(--space-lg)' }}>
        <Story />
      </div>
    )
  ]
}
