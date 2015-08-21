
define(
  ['react'],
  function(React) {
    return React.createClass({
      render: function() {
        return (
          <i className={"fa fa-" + this.props.icon}></i>
        );
      }
    });
  }
);