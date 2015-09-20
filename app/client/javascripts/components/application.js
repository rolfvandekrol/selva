
var React = require('react');

var Sidebar = require('./sidebar.js');
var Header = require('./header.js');
var MainContent = require('./main-content.js');

var WindowActionCreators = require('../action_creators/window.js');

var mapping = {
  desktop: 1024,
  tablet: 600,
  mobile: 0
};

var getStateFromWidth = function(width) {
  for (var state in mapping) { 
    if (mapping.hasOwnProperty(state)) {
      if (width >= mapping[state]) {
        return state;
      }
    }
  }

  return 'desktop';
};

var oldWidth = null;
var oldState = null;

var resizeHandler = function() {
  var width = window.innerWidth;
  if (oldWidth == null || width != oldWidth) {
    var state = getStateFromWidth(width);
    if (oldState == null || state != oldState) {
      WindowActionCreators.switchState(state);
      oldState = state;
    }
    oldWidth = width;
  }
};

var resizeTimeout;
var resizeThrottler = function() {
  if ( !resizeTimeout ) {
    resizeTimeout = setTimeout(function() {
      resizeTimeout = null;
      resizeHandler();
   
     // The actualResizeHandler will execute at a rate of 15fps
     }, 66);
  }
};

module.exports = React.createClass({
  displayName: 'Application',

  componentDidMount: function() {
    resizeThrottler();
    window.addEventListener('resize', resizeThrottler, false);
  },
  componentWillUnmount: function() {
    window.removeEventListener('resize', resizeThrottler, false);
  },

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