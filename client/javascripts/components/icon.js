
var React = require('react');

module.exports = React.createClass({
  displayName: 'Icon',

  propTypes: {
    icon: React.PropTypes.string.isRequired
  },

  render: function() {
    return (
      <i className={"fa fa-" + this.props.icon}></i>
    );
  }
});