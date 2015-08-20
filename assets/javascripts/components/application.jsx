Selva.Application = React.createClass({
  render: function() {
    return (
      <div className="application">
        <Selva.Sidebar />
        <Selva.Header />
        <Selva.MainContent />
      </div>
    );
  }
});