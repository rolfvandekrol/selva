
var React = require('react');

var Icon = require('./icon.js');
var Logo = require('./logo.js');
var Menu = require('./menu.js');

var SidebarCollapseStore = require('../stores/sidebar_collapse_store.js');
var SidebarActionCreators = require('../action_creators/sidebar.js');

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

  getInitialState: function() {
    return getStateFromStore();
  },

  render: function() {
    if (this.state.state == 'open') {
      return (
        <div className="sidebar-collapse-button">
          <button onClick={this.handleClick}><Icon icon="caret-left" /></button>
        </div>
      );
    } else {
      return (
        <div className="sidebar-collapse-button">
          <button onClick={this.handleClick}><Icon icon="navicon" /></button>
        </div>
      );
    }
  },

  handleClick: function(e) {
    e.preventDefault();
    SidebarActionCreators.switch();
  },

  componentDidMount: function() {
    SidebarCollapseStore.addListener(this._onSwitch);
  },
  componentWillUnmount: function() {
    SidebarCollapseStore.removeListener(this._onSwitch);
  },

  _onSwitch: function() {
    this.setState(getStateFromStore());
  }
});

module.exports = React.createClass({
  displayName: 'Sidebar',

  getInitialState: function() {
    return getStateFromStore();
  },

  componentDidMount: function() {
    setBodyAttribute(this.state.state);
    SidebarCollapseStore.addListener(this._onSwitch);
  },
  componentWillUnmount: function() {
    SidebarCollapseStore.removeListener(this._onSwitch);
  },
  componentDidUpdate: function() {
    setBodyAttribute(this.state.state);
  },

  render: function() {
    return (
      <div className="sidebar">
        <CollapseButton />
        <Logo />
        <Menu />
      </div>
    );
  },

  _onSwitch: function() {
    this.setState(getStateFromStore());
  }
});