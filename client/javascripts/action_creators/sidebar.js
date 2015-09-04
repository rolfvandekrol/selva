
var Dispatcher = require('../dispatcher.js');
var Constants = require('../constants.js');

module.exports = {
  switch: function() {
    Dispatcher.dispatch({
      type: Constants.ActionTypes.SIDEBAR_SWITCH
    });
  }
};