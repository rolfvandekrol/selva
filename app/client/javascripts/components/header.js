
var React = require('react');

var Icon = require('./icon.js');

var Search = React.createClass({
  displayName: 'HeaderSearch',

  getInitialState: function() {
    return {text: ''};
  },
  render: function() {
    var closeButton = [];
    if (this.state.text != '') {
      closeButton = (
        <button className="header-search-empty" onClick={this.handleEmptyClick}><Icon icon="close" /></button>
      );
    }
    return (
      <div className="header-search">
        <form>
          <button className="header-search-active" onClick={this.handleActivateClick}><Icon icon="search" /></button>
          <input type="textfield" placeholder="Zoeken" ref="searchField" onChange={this.handleTextChange} value={this.state.text} />
          {closeButton}
        </form>
      </div>
    );
  },
  handleTextChange: function(event, value) {
    this.setState({text: event.target.value});
  },
  handleActivateClick: function(e) {
    e.preventDefault();
    React.findDOMNode(this.refs.searchField).focus();
  },
  handleEmptyClick: function(e) {
    e.preventDefault();
    this.setState({text: ''});
  }
});

var Buttons = React.createClass({
  displayName: 'HeaderButtons',
  render: function() {
    return (
      <div className="header-buttons">
        <button className="header-buttons-logout"><Icon icon="sign-out" /></button>
      </div>
    );
  }
});

module.exports = React.createClass({
  displayName: 'Header',
  render: function() {
    return (
      <div className="header">
        <Search />
        <Buttons />
      </div>
    );
  }
});