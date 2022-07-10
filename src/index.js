const { app, BrowserWindow, ipcMain } = require('electron');
const path = require('path');
const storage = require('electron-json-storage');

// Handle creating/removing shortcuts on Windows when installing/uninstalling.
// eslint-disable-next-line global-require
if (require('electron-squirrel-startup')) {
  app.quit();
}

const createWindow = () => {
  // Create the browser window.
  const mainWindow = new BrowserWindow({
    minWidth: 650,
    minHeight: 470,
    width: 982,
    height: 668,
    show: false,
    frame: false,
    autoHideMenuBar: false,
    backgroundColor: '#2c2f33',
    webPreferences: {
      nodeIntegration: true,
      contextIsolation: false,
      preload: path.join(__dirname, 'preload.js'),
    },
  });

  // create a new `loading_window`-Window 
  const loading_window = new BrowserWindow({
    minWidth: 170,
    minHeight: 170,
    width: 230,
    height: 230,
    frame: false,
    show: false,
    autoHideMenuBar: true,
    backgroundColor: '#2c2f33',
    alwaysOnTop: true
  });

  loading_window.loadFile(path.join(__dirname, 'loading.html'));
  loading_window.on("ready-to-show", (e) => {
    mainWindow.loadFile(path.join(__dirname, 'index.html'));
    loading_window.focus();
    loading_window.show();
  })

  mainWindow.once('ready-to-show', () => {
    loading_window.destroy();
    set_window_bounds(mainWindow, storage).then(() => {
      mainWindow.focus();
      mainWindow.show();
    })
  });

  mainWindow.on("resize", (r) => {
    storage.set("screen-last-pos", mainWindow.getBounds())
  })

  mainWindow.on("moved", (e) => {
    storage.set("screen-last-pos", mainWindow.getBounds())
  })

  ipcMain.on("minimize-btn", (event, arg) => {
    mainWindow.minimize()
    storage.set("screen-last-pos", mainWindow.getBounds(), (err, data) => {
      console.log("minimizing app")
    })
  });
  
  ipcMain.on("maximize-btn", (event, arg) => {
    mainWindow.maximize();
    storage.get("screen-last-pos", mainWindow.getBounds(), (err, data) => {
      console.log("maximizing app")
    })
  });

  ipcMain.on("close-btn", (event, arg) => {
    storage.set("screen-last-pos", mainWindow.getBounds());
    storage.set("screen-last-pos", mainWindow.getBounds(), (err, data) => {
      console.log('quitting app but saving settings first')
      app.quit()
    })
  });

  // Open the DevTools.
  mainWindow.webContents.openDevTools();
};

// This method will be called when Electron has finished
// initialization and is ready to create browser windows.
// Some APIs can only be used after this event occurs.
app.on('ready', createWindow);

// Quit when all windows are closed, except on macOS. There, it's common
// for applications and their menu bar to stay active until the user quits
// explicitly with Cmd + Q.
app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') {
    app.quit();
  }
});

app.on('activate', () => {
  // On OS X it's common to re-create a window in the app when the
  // dock icon is clicked and there are no other windows open.
  if (BrowserWindow.getAllWindows().length === 0) {
    createWindow();
  }
});

function set_window_bounds (mainWindow, storage) {
  return new Promise((resolve, reject) => {
    storage.get("screen-last-pos", (err, data) => {
      if (!err) {
          if (data.x == undefined) {
            storage.set("screen-last-pos", mainWindow.getBounds())
          } else {
            mainWindow.setBounds(data)
          }
      }
      resolve()
    })
  })
}