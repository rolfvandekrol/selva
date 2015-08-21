
define(
  ['react', 'components/icon'],
  function(React, Icon) {
    var Search = React.createClass({
      render: function() {
        return (
          <div className="header-search">
            <form>
              <button class="header-search-active"><Icon icon="search" /></button>
              <input type="textfield" placeholder="Zoeken" />
            </form>
          </div>
        );
      }
    });

    return React.createClass({
      render: function() {
        return (
          <div className="header">
            <Search />
          </div>
        );
      }
    });
  }
);