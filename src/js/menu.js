// const ipcRenderer = window.ipcRenderer;
const {ipcRenderer} = require('electron');
/**
 * Sends IPC call to window.close() and will also call app.close() after all processes end.
 * @function
 */
function close_app() {
    ipcRenderer.send("close-btn", true);
}

/**
 * Sends IPC call to window.minimize()
 * @function
 */
 function maximize_app() {
    ipcRenderer.send("maximize-btn", true);
}

/**
 * Sends IPC call to window.minimize()
 * @function
 */
function minimize_app() {
    ipcRenderer.send("minimize-btn", true);
}