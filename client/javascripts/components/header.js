
var React = require('react');

var Icon = require('./icon.js');

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

module.exports = React.createClass({
  render: function() {
    return (
      <div className="header">
        <Search />
      </div>
    );
  }
});