const { contextBridge, ipcMain, ipcRenderer} = require('electron')

let bridge = {
    search_for_device: async () => {
        var result = await ipcRenderer.invoke("search_for_device");
    },
    close_app: () => {
        ipcRenderer.send("close-btn", true);
    },
    maximize_app: () => {
        ipcRenderer.send("maximize-btn", true);
    },
    minimize_app: () => {
        ipcRenderer.send("minimize-btn", true);
    }
}

contextBridge.exposeInMainWorld("bridge", bridge);