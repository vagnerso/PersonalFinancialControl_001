import { contextBridge, ipcRenderer } from 'electron'

// Única ponte entre o renderer e o processo principal: expõe funções específicas, nunca o ipcRenderer
contextBridge.exposeInMainWorld('api', {
  category: {
    list: () => ipcRenderer.invoke('category:list')
  }
})
