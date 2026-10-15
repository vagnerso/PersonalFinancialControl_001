import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import App from '@pfc/ui/App.jsx'
import { createServices } from './services'

createRoot(document.getElementById('root')).render(
  <StrictMode>
    <App services={createServices()} />
  </StrictMode>
)
