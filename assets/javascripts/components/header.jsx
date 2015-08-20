
Selva.Header = React.createClass({
  render: function() {
    return (
      <div className="header">
        <Selva.Header.Search />
      </div>
    );
  }
});

Selva.Header.Search = React.createClass({
  render: function() {
    return (
      <div className="header-search">
        <form>
          <button class="header-search-active"><Selva.Icon icon="search" /></button>
          <input type="textfield" placeholder="Zoeken" />
        </form>
      </div>
    );
  }
});