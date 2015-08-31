
var React = require('react');

var Icon = require('./icon.js');
var Logo = require('./logo.js');

module.exports = React.createClass({
  render: function() {
    return (
      <div className="sidebar">
        <p>Hello, world! I am a Sidebar. <Icon icon="inbox" /></p>
        <Logo />
      </div>
    );
  }
});