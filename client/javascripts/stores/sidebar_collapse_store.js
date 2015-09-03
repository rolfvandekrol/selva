
var fbemitter = require('fbemitter');

var emitter = new fbemitter.EventEmitter();

var EVENT_NAME = 'switch';

var state = 'open';
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
    emitter.emit();
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
      emit();
    }
  }
};