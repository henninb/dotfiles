var restify = require('restify');

function respond(req, res, next) {
  // res.setHeader("content-type", "text/html");
  res.contentType = "text/plain";
  // res.setHeader('content-type', 'application/foo');
  // res.send('hello '+ req.params.name);
  res.end('<html><head><title>test</title></head><body><h1>hello</h1></body></html>');

// var body = '<html><body>hello</body></html>';
// res.writeHead(200, {
//   'Content-Length': Buffer.byteLength(body),
//   'Content-Type': 'text/html'
// });
// res.write(body);
// res.end();

  console.log("response");
}

// server.get("/", function (req, res, next) {
//     fs.readFile(__dirname + "/index.html", "utf-8", function (err, file) {
//         if (err) {
//             return next(err);
//         }

//         res.setHeader("content-type", "text/html");
//         res.send(file);
//         return next();
//     });
// });


var server = restify.createServer();
server.get('/hello/:name', respond);
server.head('/hello/:name', respond);

server.listen(8080, function() {
   console.log('%s listening at %s', server.name, server.url);
});
