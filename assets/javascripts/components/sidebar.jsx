
define(
  ['react', 'components/icon'],
  function(React, Icon) {
    return React.createClass({
      render: function() {
        return (
          <div className="sidebar">
            Hello, world! I am a Sidebar. <Icon icon="inbox" />
          </div>
        );
      }
    });
  }
);