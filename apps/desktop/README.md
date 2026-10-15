# desktop

Aplicação desktop (Electron) do Personal Financial Control. Foi criada a partir do template [electron-vite](https://electron-vite.org) (`@quick-start/electron`, variante `react` em JavaScript) e faz parte do monorepo da raiz.

As telas e as regras de negócio **não ficam aqui**. Elas estão nos pacotes compartilhados com a aplicação web: `@pfc/ui` (`packages/ui/`) e `@pfc/domain` (`packages/domain/`). Aqui fica só o que é específico do desktop:

```
src/main/                   processo principal: janela, banco de dados, handlers IPC
src/preload/                ponte segura entre main e renderer (contextBridge)
src/renderer/index.html     página carregada pela janela
src/renderer/src/main.jsx   monta o App de @pfc/ui, passando os serviços do desktop
src/renderer/src/services/  createServices(): implementa os contratos de @pfc/ui/services via IPC
electron.vite.config.mjs    build e dev (electron-vite)
electron-builder.yml        empacotamento (ferramenta ainda não confirmada)
build/, resources/          ícones e recursos do instalador e da janela
```

A entrada do renderer só faz isto:

```jsx
<App services={createServices()} />
```

O `App` de `@pfc/ui` repassa os serviços às telas pelo `ServicesProvider`, e cada tela os obtém com `useServices()`. Hoje, `createServices()` devolve um objeto vazio, porque o driver SQLite ainda não foi definido.

Os pacotes `@pfc/*` ficam em `devDependencies`. Assim, o electron-vite embute o código deles no bundle, e o instalador não precisa copiá-los como dependências.

## Comandos

Rode **na raiz do repositório**, não nesta pasta, porque as dependências são instaladas pelo npm workspaces:

```bash
npm install             # instala tudo (inclui o binário do Electron)
npm run dev:desktop     # modo de desenvolvimento, com recarga automática
npm run build:desktop   # build de produção em apps/desktop/out/
npm run lint            # ESLint de todo o monorepo (a configuração fica na raiz)
```

ESLint, Prettier, `.editorconfig` e as configurações do VS Code (incluindo a depuração "Debug All") ficam na raiz e valem para todo o monorepo.

Os scripts `build:win`, `build:mac` e `build:linux` (electron-builder) vieram do template. A ferramenta de empacotamento ainda não foi confirmada; veja o CLAUDE.md.

## Observações

- O Electron está fixado na versão exata (`44.7.2`) no `package.json`. O electron-builder exige isso quando o Electron fica no `node_modules` da raiz.
- Se `npm run dev:desktop` falhar com `Cannot read properties of undefined (reading 'isPackaged')`, a variável `ELECTRON_RUN_AS_NODE` está definida no terminal. Remova-a com `Remove-Item Env:ELECTRON_RUN_AS_NODE` (PowerShell) ou `unset ELECTRON_RUN_AS_NODE` (bash).
