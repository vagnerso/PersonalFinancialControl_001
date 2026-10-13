import { useEffect, useRef, useState } from 'react';
import './RegisterLayout.css';

// Equivalente ao template TfrmMasterRegister (SCREENS.md §3.2).
// Estados: 'search' (Consulta) e 'register' (Cadastro). A tela filha guarda os dados e
// decide o que cada ação faz; este componente cuida só do layout e do teclado.

// TODO(migração): lblFontTest ("Fonte Teste", Visible = False) não foi convertido: rótulo invisível sem uso.
// TODO(migração): nome e versão do aplicativo devem vir do empacotamento (a definir).
const APP_NAME = 'Personal Financial Control';
const APP_VERSION = '1.1.1';

export default function RegisterLayout({
  title,
  mode,
  searchText,
  onSearchTextChange,
  onSearch,
  searchInputRef,
  columns,
  rows,
  getRowKey,
  selectedIndex,
  onSelectedIndexChange,
  onInsert,
  onEdit,
  onDelete,
  onPrint,
  onClose,
  onSave,
  onCancel,
  keyboardEnabled = true,
  children,
}) {
  const [contextMenu, setContextMenu] = useState(null);
  const gridRef = useRef(null);

  useEffect(() => {
    document.title = `${APP_NAME} - Versão: ${APP_VERSION} - ${title}`;
  }, [title]);

  // KeyPreview + FormCloseWithEsc: Esc fecha a tela em qualquer estado.
  // Com o menu de contexto aberto, Esc fecha só o menu.
  useEffect(() => {
    if (!keyboardEnabled) return undefined;
    function handleKeyDown(event) {
      if (event.key !== 'Escape') return;
      if (contextMenu) {
        setContextMenu(null);
      } else {
        onClose();
      }
    }
    window.addEventListener('keydown', handleKeyDown);
    return () => window.removeEventListener('keydown', handleKeyDown);
  }, [keyboardEnabled, contextMenu, onClose]);

  useEffect(() => {
    if (!contextMenu) return undefined;
    const close = () => setContextMenu(null);
    window.addEventListener('mousedown', close);
    window.addEventListener('blur', close);
    return () => {
      window.removeEventListener('mousedown', close);
      window.removeEventListener('blur', close);
    };
  }, [contextMenu]);

  // Mantém a linha selecionada visível quando a seleção muda pelo teclado.
  useEffect(() => {
    const row = gridRef.current?.querySelector('.register-layout-row-selected');
    row?.scrollIntoView({ block: 'nearest' });
  }, [selectedIndex, rows]);

  function moveSelection(step) {
    if (rows.length === 0) return;
    const next = Math.min(Math.max(selectedIndex + step, 0), rows.length - 1);
    onSelectedIndexChange(next);
  }

  // edtSearchKeyPress (Enter pesquisa) e edtSearchKeyDown (↑/↓ movem a seleção da grade).
  function handleSearchKeyDown(event) {
    if (event.key === 'Enter') {
      event.preventDefault();
      onSearch();
    } else if (event.key === 'ArrowUp') {
      moveSelection(-1);
    } else if (event.key === 'ArrowDown') {
      moveSelection(1);
    }
  }

  function handleGridKeyDown(event) {
    if (event.key === 'ArrowUp') {
      event.preventDefault();
      moveSelection(-1);
    } else if (event.key === 'ArrowDown') {
      event.preventDefault();
      moveSelection(1);
    }
  }

  function handleGridContextMenu(event) {
    event.preventDefault();
    setContextMenu({ x: event.clientX, y: event.clientY });
  }

  function runMenuAction(action) {
    setContextMenu(null);
    action();
  }

  const isSearch = mode === 'search';

  return (
    <div className="register-layout">
      <header className="register-layout-title">{title}</header>

      {isSearch && (
        <section className="register-layout-search">
          <div className="register-layout-tabs" role="tablist">
            <span className="register-layout-tab register-layout-tab-active" role="tab" aria-selected="true">
              Opções de pesquisa
            </span>
          </div>
          <div className="register-layout-search-panel">
            <label htmlFor="register-layout-search-input" className="register-layout-label">
              Pesquisar
            </label>
            <div className="register-layout-search-row">
              <input
                id="register-layout-search-input"
                ref={searchInputRef}
                type="text"
                className="register-layout-input register-layout-search-input"
                placeholder="Digite aqui o que deseja pesquisar"
                value={searchText}
                onChange={(event) => onSearchTextChange(event.target.value)}
                onKeyDown={handleSearchKeyDown}
              />
              <button
                type="button"
                className="register-layout-icon-button"
                title="Clique aqui para limpar o campo de pesquisa"
                aria-label="Limpar o campo de pesquisa"
                onClick={() => onSearchTextChange('')}
              >
                <img src="/images/clear_white_24.png" alt="" />
              </button>
              <button
                type="button"
                className="register-layout-icon-button"
                title="Clique aqui para executar a pesquisa"
                aria-label="Executar a pesquisa"
                onClick={onSearch}
              >
                <img src="/images/search_white_24.png" alt="" />
              </button>
            </div>
          </div>
        </section>
      )}

      <div className="register-layout-body">
        {isSearch && (
          <nav className="register-layout-actions" aria-label="Ações">
            <button type="button" className="register-layout-button" onClick={onInsert}>
              Incluir
            </button>
            <button type="button" className="register-layout-button" onClick={onEdit}>
              Alterar
            </button>
            <button type="button" className="register-layout-button" onClick={onDelete}>
              Excluir
            </button>
            <button type="button" className="register-layout-button" onClick={onPrint}>
              Imprimir
            </button>
            <button type="button" className="register-layout-button" onClick={onClose}>
              Fechar
            </button>
          </nav>
        )}

        <main className="register-layout-main">
          <div className="register-layout-tabs" role="tablist">
            <span className="register-layout-tab register-layout-tab-active" role="tab" aria-selected="true">
              {isSearch ? 'Consulta' : 'Cadastro'}
            </span>
          </div>

          {isSearch ? (
            <div
              ref={gridRef}
              className="register-layout-grid"
              tabIndex={0}
              onKeyDown={handleGridKeyDown}
              onContextMenu={handleGridContextMenu}
            >
              <table className="register-layout-table">
                <thead>
                  <tr>
                    <th className="register-layout-indicator" aria-hidden="true" />
                    {columns.map((column) => (
                      <th key={column.key} style={{ width: column.width }}>
                        {column.title}
                      </th>
                    ))}
                    <th className="register-layout-filler" aria-hidden="true" />
                  </tr>
                </thead>
                <tbody>
                  {rows.map((row, index) => {
                    const selected = index === selectedIndex;
                    return (
                      <tr
                        key={getRowKey(row)}
                        className={selected ? 'register-layout-row-selected' : undefined}
                        aria-selected={selected}
                        onClick={() => onSelectedIndexChange(index)}
                        onDoubleClick={() => {
                          onSelectedIndexChange(index);
                          onEdit();
                        }}
                      >
                        <td className="register-layout-indicator" aria-hidden="true">
                          {selected ? '▸' : ''}
                        </td>
                        {columns.map((column) => (
                          <td key={column.key}>{row[column.key]}</td>
                        ))}
                        <td className="register-layout-filler" aria-hidden="true" />
                      </tr>
                    );
                  })}
                </tbody>
              </table>
            </div>
          ) : (
            <div className="register-layout-register">
              <div className="register-layout-tabs register-layout-subtabs" role="tablist">
                <span className="register-layout-tab register-layout-tab-active" role="tab" aria-selected="true">
                  Básico
                </span>
              </div>
              <div className="register-layout-register-panel">{children}</div>
              <div className="register-layout-register-buttons">
                <button type="button" className="register-layout-button" onClick={onSave}>
                  Salvar
                </button>
                <button type="button" className="register-layout-button" onClick={onCancel}>
                  Cancelar
                </button>
              </div>
            </div>
          )}
        </main>
      </div>

      <footer className="register-layout-bottom" />

      {contextMenu && (
        <ul
          className="register-layout-context-menu"
          role="menu"
          style={{ left: contextMenu.x, top: contextMenu.y }}
          onMouseDown={(event) => event.stopPropagation()}
        >
          <li role="none">
            <button type="button" role="menuitem" onClick={() => runMenuAction(onInsert)}>
              Incluir
            </button>
          </li>
          <li role="none">
            <button type="button" role="menuitem" onClick={() => runMenuAction(onEdit)}>
              Alterar
            </button>
          </li>
          <li role="none">
            <button type="button" role="menuitem" onClick={() => runMenuAction(onDelete)}>
              Excluir
            </button>
          </li>
          <li role="none">
            <button type="button" role="menuitem" onClick={() => runMenuAction(onPrint)}>
              Imprimir
            </button>
          </li>
          <li role="separator" className="register-layout-context-separator" />
          <li role="none">
            <button type="button" role="menuitem" onClick={() => runMenuAction(onClose)}>
              Fechar
            </button>
          </li>
        </ul>
      )}
    </div>
  );
}
