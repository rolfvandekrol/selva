
var Dispatcher = require('../dispatcher.js');
var Constants = require('../constants.js');

module.exports = {
  switchState: function(state) {
    Dispatcher.dispatch({
      type: Constants.ActionTypes.WINDOW_STATE_SWITCH,
      state: state
    });
  }
};