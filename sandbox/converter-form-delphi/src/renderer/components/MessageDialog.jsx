import { useEffect, useRef } from 'react';
import './MessageDialog.css';

// Equivalente a TfrmMessage.ShowMessageBox (SCREENS.md §3.4, RN-61).
const MESSAGE_TYPES = {
  success: { title: 'Sucesso', icon: '/images/outline_check_circle_white_48dp.png' },
  warning: { title: 'Atenção', icon: '/images/outline_warning_white_48dp.png' },
  error: { title: 'Erro', icon: '/images/outline_error_white_48dp.png' },
  information: { title: 'Informação', icon: '/images/outline_priority_high_white_48dp.png' },
};

export default function MessageDialog({ type, title, message, onClose }) {
  const dialogRef = useRef(null);
  const okRef = useRef(null);
  const { title: defaultTitle, icon } = MESSAGE_TYPES[type];

  useEffect(() => {
    dialogRef.current.showModal();
    okRef.current.focus();
  }, []);

  // No Delphi, Esc não fecha a mensagem: só OK ou Enter.
  function handleCancel(event) {
    event.preventDefault();
  }

  function handleKeyDown(event) {
    if (event.key === 'Enter') {
      event.preventDefault();
      onClose();
    }
  }

  return (
    <dialog
      ref={dialogRef}
      className="message-dialog"
      onCancel={handleCancel}
      onKeyDown={handleKeyDown}
      aria-labelledby="message-dialog-type"
    >
      <div className="message-dialog-panel">
        <div className="message-dialog-title" />
        <div className="message-dialog-body">
          <img className="message-dialog-icon" src={icon} alt="" />
          <span id="message-dialog-type" className="message-dialog-type">
            {title && title.trim() !== '' ? title : defaultTitle}
          </span>
          <p className="message-dialog-text">{message}</p>
        </div>
        <div className="message-dialog-menu">
          <button ref={okRef} type="button" className="message-dialog-button" onClick={onClose}>
            Ok
          </button>
        </div>
      </div>
    </dialog>
  );
}
