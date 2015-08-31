
require("../stylesheets/application.scss");
require("../stylesheets/themes/default.scss");

var React = require('react');
var Application = require('./components/application.js');

React.render(
  <Application />,
  document.getElementById('wrapper')
);