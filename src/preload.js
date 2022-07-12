const { contextBridge, ipcMain, ipcRenderer} = require('electron')

let bridge = {
    searchForDevice: async () => {
        var result = await ipcRenderer.invoke("searchForDevice");
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