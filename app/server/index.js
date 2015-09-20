
var path = require('path');

var express = require('express');
var app = express();
var server = require('http').Server(app);
var io = require('socket.io')(server);

var root_path = path.normalize(__dirname + '/../..');
var client_path = root_path + '/app/client';

server.listen(4567);

app.use('/a', express.static(client_path + '/dist'));

app.get('/', function (req, res) {
  res.sendFile(client_path + '/html/index.html');
});

io.on('connection', function (socket) {
  socket.emit('news', { hello: 'world' });
  socket.on('my other event', function (data) {
    console.log(data);
  });
});

app.use(function(req, res, next) {
  res.status(404).sendFile(client_path + '/html/404.html');
});