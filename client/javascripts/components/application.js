
var React = require('react');

var Sidebar = require('./sidebar.js');
var Header = require('./header.js');
var MainContent = require('./main-content.js');

module.exports = React.createClass({
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