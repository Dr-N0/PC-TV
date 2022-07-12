/**
 * Sends IPC call to window.close() and will also call app.close() after all processes end.
 * @function
 */
function close_app() {
    window.bridge.close_app();
}

/**
 * Sends IPC call to window.minimize()
 * @function
 */
 function maximize_app() {
    window.bridge.maximize_app();
}

/**
 * Sends IPC call to window.minimize()
 * @function
 */
function minimize_app() {
    window.bridge.minimize_app();
}