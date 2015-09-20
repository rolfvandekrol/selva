
var React = require('react');

var Icon = require('./icon.js');

var Item = React.createClass({
  displayName: 'MenuItem',

  propTypes: {
    icon: React.PropTypes.string.isRequired,
    label: React.PropTypes.string.isRequired
  },

  render: function() {
    return (
      <li><Icon icon={this.props.icon} /><span>{this.props.label}</span></li>
    );
  },
});

module.exports = React.createClass({
  displayName: 'Menu',

  render: function() {
    return (
      <div className="menu">
        <ul>
          <Item label="Projects" icon="folder" />
          <Item label="Internal" icon="power-off" />
        </ul>
      </div>
    );
  },
});