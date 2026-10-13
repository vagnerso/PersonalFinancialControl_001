import { useEffect, useRef } from 'react';
import './ConfirmDialog.css';

// Equivalente ao Application.MessageBox Sim/Não (SCREENS.md §3.4, RN-61): foco padrão em Não.
export default function ConfirmDialog({ title, message, onYes, onNo }) {
  const dialogRef = useRef(null);
  const noRef = useRef(null);

  useEffect(() => {
    dialogRef.current.showModal();
    noRef.current.focus();
  }, []);

  // A caixa Sim/Não do Windows não fecha com Esc: é preciso escolher uma opção.
  function handleCancel(event) {
    event.preventDefault();
  }

  return (
    <dialog ref={dialogRef} className="confirm-dialog" onCancel={handleCancel} aria-labelledby="confirm-dialog-title">
      <div id="confirm-dialog-title" className="confirm-dialog-title">
        {title}
      </div>
      <p className="confirm-dialog-text">{message}</p>
      <div className="confirm-dialog-buttons">
        <button type="button" className="confirm-dialog-button" onClick={onYes}>
          Sim
        </button>
        <button ref={noRef} type="button" className="confirm-dialog-button" onClick={onNo}>
          Não
        </button>
      </div>
    </dialog>
  );
}
