const { app, BrowserWindow, ipcMain, net, shell } = require('electron');
const fetch = require('node-fetch');
const path = require('path');
const storage = require('electron-json-storage');

if (process.env.NODE_ENV !== 'production'){
  require('dotenv').config();
}

// Handle creating/removing shortcuts on Windows when installing/uninstalling.
// eslint-disable-next-line global-require
if (require('electron-squirrel-startup')) {
  app.quit();
}

const isDev = process.env.NODE_ENV == 'develop';
const gotTheLock = app.requestSingleInstanceLock();
const isWifi = net.online;
let mainWindow, loading_window;

const createWindow = () => {
  // Create the browser window.
  mainWindow = new BrowserWindow({
    minWidth: 650,
    minHeight: 470,
    width: 982,
    height: 668,
    show: false,
    frame: false,
    center: true,
    autoHideMenuBar: false,
    backgroundColor: '#2c2f33',
    icon: __dirname + '/renderer/style/assets/pcTV.ico',
    webPreferences: {
      nodeIntegration: false,
      contextIsolation: true,
      devTools: isDev,
      preload: path.join(__dirname, 'preload.js'),
    }
  });

  // create a new `loading_window`-Window 
  loading_window = new BrowserWindow({
    minWidth: 170,
    minHeight: 170,
    width: 230,
    height: 230,
    frame: false,
    show: false,
    center: true,
    autoHideMenuBar: true,
    backgroundColor: '#2c2f33',
    alwaysOnTop: true,
    webPreferences: {
      devTools: false,
    }
  });

  // =======================================
  // Display loading window and main window
  // =======================================
  loading_window.loadFile(path.join(__dirname, './renderer/loading.html'));
  loading_window.on("ready-to-show", (e) => {
    mainWindow.loadFile(path.join(__dirname, './renderer/index.html'));
    loading_window.focus();
    loading_window.show();
  });

  mainWindow.once('ready-to-show', () => {
    loading_window.destroy();
    set_window_bounds(mainWindow, storage).then(() => {
      mainWindow.focus();
      mainWindow.show();
    })
    mainWindow.focus();
  });

  // =======================================
  // Main Window Controlls
  // =======================================
  mainWindow.on("resize", (r) => {
    storage.set("screen-last-pos", mainWindow.getBounds())
  });

  mainWindow.on("moved", (e) => {
    storage.set("screen-last-pos", mainWindow.getBounds())
  });

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
    app.quit();
  });

  ipcMain.handle("search_for_device", async () => {
    if(isWifi){
      // ===== LET MAIN SERVER KNOW YOU'RE LOOKING
      try {
        const body = {
          login_token: "test-token:happybirthday1234123",
          device_token: "device-token:oogabooga",
          searching: true
        };
        const response = await fetch('http://localhost:5000/api/pc_searching', {
          method: 'post',
          headers: {'Content-Type': 'application/json'},
          body: JSON.stringify(body)
        });
        const data = await response.json();

        if(data.connected == true){
          mainWindow.loadFile(path.join(__dirname, './renderer/connected.html'));
        }else{
          console.log("Didn't work")
        }
      } catch (err) {
        console.log(err.message);
      }
    }
  });

  // Open Dev Tools
  if (isDev){
    mainWindow.webContents.openDevTools();
  }
};

if (!gotTheLock) {
  app.quit()
} else {
  app.on('second-instance', (event, commandLine, workingDirectory) => {
    // Someone tried to run a second instance, we should focus our window.
    if (mainWindow) {
      if (mainWindow.isMinimized()) mainWindow.restore()
      mainWindow.focus();
    }
  })
    
  // Create myWindow, load the rest of the app, etc...
  app.on('ready', createWindow);
}

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

function set_window_bounds(mainWindow, storage) {
  return new Promise((resolve, reject) => {
    storage.get("screen-last-pos", (err, data) => {
      if (!err) {
          if (data.x == undefined) {
            storage.set("screen-last-pos", mainWindow.getBounds());
          } else {
            mainWindow.setBounds(data);
          }
      }
      resolve();
    });
  });
}