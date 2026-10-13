// Ponto de entrada da sandbox: importe aqui a tela convertida que estiver em teste.
import { useState } from 'react';
import Category from './renderer/screens/Category/Category.jsx';
import './renderer/styles/theme.css';

export default function App() {
  const [open, setOpen] = useState(true);

  if (!open) {
    return (
      <p style={{ color: 'var(--color-label)', padding: 16 }}>
        Tela fechada. <button type="button" onClick={() => setOpen(true)}>Abrir Categorias</button>
      </p>
    );
  }

  return <Category onClose={() => setOpen(false)} />;
}
