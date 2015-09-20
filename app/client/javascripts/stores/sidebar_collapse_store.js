
var Dispatcher = require('../dispatcher.js');
var Constants = require('../constants.js');

var fbemitter = require('fbemitter');

var emitter = new fbemitter.EventEmitter();

var EVENT_NAME = 'switch';

var state = 'default';
var mapping = {
  'open': 'closed',
  'closed': 'open',
};

module.exports = {
  addListener: function(callback) {
    emitter.addListener(EVENT_NAME, callback);
  },
  removeListener: function(callback) {
    emitter.removeListener(EVENT_NAME, callback);
  },
  emit: function() {
    emitter.emit(EVENT_NAME);
  },
  state: function() {
    return state;
  },

  open: function() {
    this.setState('open');
  },
  close: function() {
    this.setState('closed');
  },
  switch: function() {
    this.setState(mapping[state]);
  },

  setState: function(new_state) {
    if (new_state != state) {
      state = new_state;
      this.emit();
    }
  }
};

module.exports.dispatchToken = Dispatcher.register(function(action) {
  switch(action.type) {
    case Constants.ActionTypes.SIDEBAR_SWITCH:
      module.exports.switch();
      break;
    case Constants.ActionTypes.WINDOW_STATE_SWITCH:
      if (action.state == 'desktop') {
        module.exports.open();
      } else {
        module.exports.close();
      }
      break;
  }
});