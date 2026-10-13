import { useEffect, useRef, useState } from 'react';
import RegisterLayout from '../../components/RegisterLayout.jsx';
import MessageDialog from '../../components/MessageDialog.jsx';
import ConfirmDialog from '../../components/ConfirmDialog.jsx';
import {
  searchCategories,
  insertCategory,
  updateCategory,
  deleteCategory,
} from '../../services/categoryService.js';
import './Category.css';

// Tela de Categorias (forms/fCategory.pas, TfrmCategory), sobre o layout de cadastro (TfrmMasterRegister).

const TITLE = 'Categorias';
const APP_TITLE = 'Personal Financial Control';
const COLUMNS = [{ key: 'name', title: 'Nome', width: 400 }];

// Mensagens de class/uAppConstants.pas (RN-61).
const MSG_ERROR_CATEGORY_INSERT = 'Erro ao tentar incluir uma categoria.';
const MSG_ERROR_CATEGORY_UPDATE = 'Erro ao tentar alterar uma categoria.';
const MSG_ERROR_CATEGORY_DELETE = 'Erro ao tentar excluir uma categoria.';

export default function Category({ onClose }) {
  const [mode, setMode] = useState('search');
  const [operation, setOperation] = useState(null);
  const [searchText, setSearchText] = useState('');
  const [rows, setRows] = useState([]);
  const [selectedIndex, setSelectedIndex] = useState(-1);
  const [name, setName] = useState('');
  const [dialog, setDialog] = useState(null);
  const searchInputRef = useRef(null);
  const nameInputRef = useRef(null);

  // Linha corrente da grade. Sem registros, o Delphi lê '' dos campos (FieldByName em consulta vazia).
  const selectedRow = rows[selectedIndex] ?? null;

  function showMessage(type, message) {
    return new Promise((resolve) => setDialog({ kind: 'message', type, message, resolve }));
  }

  function askConfirmation(message) {
    return new Promise((resolve) => setDialog({ kind: 'confirm', message, resolve }));
  }

  function closeDialog(result) {
    dialog.resolve(result);
    setDialog(null);
  }

  // SearchExecute: consulta pelo texto (RN-15); a grade abre posicionada no primeiro registro.
  async function searchExecute(text) {
    try {
      const result = await searchCategories(text);
      setRows(result);
      setSelectedIndex(result.length > 0 ? 0 : -1);
    } catch (error) {
      // TODO(migração): no Delphi, TCategory.Search não trata erros (aparece a exceção padrão do Delphi).
      await showMessage('error', error.message);
    }
  }

  // FormShow: pesquisa vazia, foco no campo de pesquisa e lista todos os registros.
  useEffect(() => {
    searchInputRef.current?.focus();
    searchExecute('');
  }, []);

  // EnabledRegister + edtName.SetFocus (Incluir e Alterar).
  useEffect(() => {
    if (mode === 'register') nameInputRef.current?.focus();
  }, [mode]);

  // InsertRegister. ClearFields limpa todos os TEdit da tela, inclusive o campo de pesquisa.
  function handleInsert() {
    setOperation('insert');
    setName('');
    setSearchText('');
    setMode('register');
  }

  // EditRegister: preenche com o valor da linha da grade, sem reler o banco.
  function handleEdit() {
    setOperation('update');
    setName(selectedRow?.name ?? '');
    setMode('register');
  }

  // SaveRegister. Sem validação de campos obrigatórios (RN-17).
  // D-04 (decisão: Manter, 12/10/2026): em caso de erro, mostra a mensagem e volta para a Consulta mesmo assim.
  async function handleSave() {
    try {
      if (operation === 'insert') {
        await insertCategory({ name });
      } else {
        await updateCategory({ uniqueId: selectedRow?.uniqueId ?? '', name });
      }
    } catch {
      await showMessage('error', operation === 'insert' ? MSG_ERROR_CATEGORY_INSERT : MSG_ERROR_CATEGORY_UPDATE);
    }
    setMode('search');
    await searchExecute(searchText);
  }

  // CancelRegister: volta para a Consulta sem gravar e sem refazer a busca.
  function handleCancel() {
    setMode('search');
  }

  // DeleteRegister (RN-16): confirmação com Não como padrão; exclusão pelo UNIQUE_ID da linha da grade.
  async function handleDelete() {
    const confirmed = await askConfirmation('Deseja realmente excluir o registro?');
    if (!confirmed) return;
    try {
      await deleteCategory(selectedRow?.uniqueId ?? '');
    } catch {
      await showMessage('error', MSG_ERROR_CATEGORY_DELETE);
    }
    await searchExecute(searchText);
  }

  // PrintRegister: vazio no Delphi (SCREENS.md §7).
  // TODO(migração): Imprimir não tem ação no Delphi; biblioteca de relatórios/PDF a definir.
  function handlePrint() {}

  // CloseForm.
  function handleClose() {
    onClose?.();
  }

  return (
    <>
      <RegisterLayout
        title={TITLE}
        mode={mode}
        searchText={searchText}
        onSearchTextChange={setSearchText}
        onSearch={() => searchExecute(searchText)}
        searchInputRef={searchInputRef}
        columns={COLUMNS}
        rows={rows}
        getRowKey={(row) => row.uniqueId}
        selectedIndex={selectedIndex}
        onSelectedIndexChange={setSelectedIndex}
        onInsert={handleInsert}
        onEdit={handleEdit}
        onDelete={handleDelete}
        onPrint={handlePrint}
        onClose={handleClose}
        onSave={handleSave}
        onCancel={handleCancel}
        keyboardEnabled={dialog === null}
      >
        <div className="category-fields">
          {/* TODO(migração): rótulo em inglês ("Name") mantido igual ao Delphi por decisão do usuário (12/10/2026). */}
          <label htmlFor="category-name" className="category-label">
            Name
          </label>
          <input
            id="category-name"
            ref={nameInputRef}
            type="text"
            className="category-input"
            value={name}
            onChange={(event) => setName(event.target.value)}
          />
        </div>
      </RegisterLayout>

      {dialog?.kind === 'message' && (
        <MessageDialog type={dialog.type} message={dialog.message} onClose={() => closeDialog()} />
      )}
      {dialog?.kind === 'confirm' && (
        <ConfirmDialog
          title={APP_TITLE}
          message={dialog.message}
          onYes={() => closeDialog(true)}
          onNo={() => closeDialog(false)}
        />
      )}
    </>
  );
}
