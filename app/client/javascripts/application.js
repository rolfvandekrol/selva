
require("../stylesheets/application.scss");
require("../stylesheets/themes/default.scss");

var React = require('react');
var Application = require('./components/application.js');
var s = require('socket.io-client');

React.render(
  <Application />,
  document.body
);