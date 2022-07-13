const http = require('http');
let port = 5000;

const requestListener = function (req, res) {
  console.log(req.body())
  res.writeHead(200);
  res.end(JSON.stringify({ a: 1 }));
}

const server = http.createServer((req, res) => {
  let data = '';
  req.on('data', chunk => {
    data += chunk;
  });
  req.on('end', () => {
    console.log(JSON.parse(data)); // 'Buy the milk'
    res.end(JSON.stringify({ a: 1 }));
  });
});

// const server = http.createServer(requestListener);
server.listen(port);
console.log("Listening on: " + port);