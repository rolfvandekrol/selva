
var React = require('react');

var Icon = require('./icon.js');
var Logo = require('./logo.js');

module.exports = React.createClass({
  displayName: 'Sidebar',
  render: function() {
    return (
      <div className="sidebar">
        <Logo />
      </div>
    );
  }
});