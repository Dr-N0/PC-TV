const { app, BrowserWindow, ipcMain, net } = require('electron');
const path = require('path');
const storage = require('electron-json-storage');

// Handle creating/removing shortcuts on Windows when installing/uninstalling.
// eslint-disable-next-line global-require
if (require('electron-squirrel-startup')) {
  app.quit();
}
// SSL/TSL: this is the self signed certificate support
app.on('certificate-error', (event, webContents, url, error, certificate, callback) => {
  // On certificate error we disable default behaviour (stop loading the page)
  // and we then say "it is all fine - true" to the callback
  console.log('alsdjfklasdfjlksfadjkljkl')
  event.preventDefault();
  callback(true);
});

const createWindow = () => {
  // Create the browser window.
  const mainWindow = new BrowserWindow({
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
      // nodeIntegration: false,
      // contextIsolation: true,
      preload: path.join(__dirname, 'preload.js'),
    }
  });

  // create a new `loading_window`-Window 
  const loading_window = new BrowserWindow({
    minWidth: 170,
    minHeight: 170,
    width: 230,
    height: 230,
    frame: false,
    show: false,
    center: true,
    autoHideMenuBar: true,
    backgroundColor: '#2c2f33',
    alwaysOnTop: true
  });

  // =======================================
  // Display loading window and main window
  // =======================================
  loading_window.loadFile(path.join(__dirname, './renderer/loading.html'));
  loading_window.on("ready-to-show", (e) => {
    mainWindow.loadFile(path.join(__dirname, './renderer/index.html'));
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

  // =======================================
  // Main Window Controlls
  // =======================================
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

  // Certificate Manager
  mainWindow.webContents.session.setCertificateVerifyProc((request, callback) => {
    var { hostname, certificate, validatedCertificate, verificationResult, errorCode } = request;

    // Calling callback(0) accepts the certificate, calling callback(-2) rejects it.
    if (isNotMyCertificate(hostname, certificate)) { callback(-2); return; }
    
    callback(0);
  });

  // Open Dev Tools
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

// app.commandLine.appendSwitch('ignore-certificate-errors');

function isNotMyCertificate(hostname, certificate){
  if(hostname === 'boredapi.com'){
    return false;
  }
}

ipcMain.handle("searchForDevice", () => {
  const request = net.request({
    method: 'GET',
    protocol: 'https:',
    hostname: 'boredapi.com',
    path: '/api/activity/',
    redirect: 'follow'
  });
  request.on('response', (response) => {
    console.log(`STATUS: ${response.statusCode}`);
    console.log(`HEADERS: ${JSON.stringify(response.headers)}`);

    response.on('data', (chunk) => {
      console.log(`BODY: ${chunk}`)
    });
  });

  request.on('finish', () => {
    console.log('Request is Finished')
  });
  request.on('abort', () => {
    console.log('Request is Aborted')
  });
  request.on('error', (error) => {
    console.log(`ERROR: ${JSON.stringify(error)}`)
  });

  request.on('close', (error) => {
    console.log('Last Transaction has occurred')
  });

  request.setHeader('Content-Type', 'application/json');
  request.end();
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

// var body = JSON.stringify({ key: 1 });
  //   const request = net.request({
  //       method: 'POST',
  //       protocol: 'http:',
  //       hostname: 'httpbin.org',
  //       path: '/post',
  //       redirect: 'follow'
  //   });
  //   request.on('response', (response) => {
  //       console.log(`STATUS: ${response.statusCode}`);
  //       console.log(`HEADERS: ${JSON.stringify(response.headers)}`);
 
  //       response.on('data', (chunk) => {
  //           console.log(`BODY: ${chunk}`)
  //       });
  //   });
  //   request.on('finish', () => {
  //       console.log('Request is Finished')
  //   });
  //   request.on('abort', () => {
  //       console.log('Request is Aborted')
  //   });
  //   request.on('error', (error) => {
  //       console.log(`ERROR: ${JSON.stringify(error)}`)
  //   });
  //   request.on('close', (error) => {
  //       console.log('Last Transaction has occurred')
  //   });
  //   request.setHeader('Content-Type', 'application/json');
  //   request.write(body, 'utf-8');
  //   request.end();