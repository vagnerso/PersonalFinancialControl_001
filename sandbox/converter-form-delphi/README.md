# Sandbox do converter-form-delphi

Area isolada para testar a skill `converter-form-delphi` e o subagente `revisor-de-tela`. Nao faz parte do aplicativo Electron nem altera o sistema Delphi.

- A estrutura de `src/` espelha a de `electron/src/` (ver CLAUDE.md): telas em `src/renderer/screens/<Tela>/`, componentes compartilhados em `src/renderer/components/`, servicos em `src/renderer/services/`, tema em `src/renderer/styles/theme.css` e regras em `src/domain/rules/`.
- Para ver uma tela no navegador, importe-a em `src/App.jsx` e execute `npm run dev`.
- `npm run build` confere se o codigo compila.
- Servicos sao stubs com dados ficticios; nao copie nem altere o banco real.
