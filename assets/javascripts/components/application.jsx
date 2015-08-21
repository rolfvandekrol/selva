
define(
  ['react', 'components/sidebar', 'components/header', 'components/main-content'],
  function(React, Sidebar, Header, MainContent) {
    return React.createClass({
      render: function() {
        return (
          <div className="application">
            <Sidebar />
            <Header />
            <MainContent />
          </div>
        );
      }
    });
  }
);