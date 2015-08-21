
define(
  ['react', 'components/icon', 'components/logo'],
  function(React, Icon, Logo) {
    return React.createClass({
      render: function() {
        return (
          <div className="sidebar">
            <p>Hello, world! I am a Sidebar. <Icon icon="inbox" /></p>
            <Logo />
          </div>
        );
      }
    });
  }
);