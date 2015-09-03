
var React = require('react');

var Icon = require('./icon.js');
var Logo = require('./logo.js');
var SidebarCollapseStore = require('../stores/sidebar_collapse_store.js');

var getStateFromStore = function() {
  return {
    state: SidebarCollapseStore.state()
  };
};

var setBodyAttribute = function(state) {
  document.body.setAttribute('data-sidebar-state', state);
}

var CollapseButton = React.createClass({
  displayName: 'SidebarCollapseButton',

  render: function() {
    return (
      <div className="sidebar-collapse-button">
        <button onClick={this.handleClick}><Icon icon="caret-left" /></button>
      </div>
    )
  },

  handleClick: function(e) {
    e.preventDefault();
  }
});

module.exports = React.createClass({
  displayName: 'Sidebar',

  getInitialState: function() {
    return getStateFromStore();
  },

  componentDidMount: function() {
    setBodyAttribute(this.state.state);
  },

  render: function() {
    return (
      <div className="sidebar">
        <CollapseButton />
        <Logo />
      </div>
    );
  }
});