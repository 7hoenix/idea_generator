var Dashboard = React.createClass({
  getInitialState: function(requested_type) {
    return {requested_type: requested_type, possibilities: [], left: [], right: []}
  },
  componentDidMount: function() {
    this.setBothPossibilities();
  },
  nextPossibility: function() {
    var tempPossibilities = this.state.possibilities
    var possibility = tempPossibilities.pop();
    this.setState({possibilities: tempPossibilities});
    return possibility;
  },
  setLeftPossibility: function() {
    console.log("I'm back to the truth");
    this.setState({left: this.nextPossibility()});
  },
  setRightPossibility: function() {
    this.setState({right: this.nextPossibility()});
  },
  setBothPossibilities: function() {
    $.ajax({
      url: "/api/v1/possibilities.json",
      type: "GET",
      data: { requested_type: "business" },
      success: function(response) {
        this.setState({possibilities: response});
        this.setLeftPossibility();
        this.setRightPossibility();
      }.bind(this)
    });
  },
  render: function() {
    return (
      <div className="section" id="dashboard-body">
        <div className="row center dashboard-card-vertical">
           <Left possibility={this.state.left} setLeftPossibility={this.setLeftPossibility} />
           <Right possibility={this.state.right} setRightPossibility={this.setRightPossibility} />
         <div className="col s2">
         </div>
       </div>
       <br/>
        <Composite left={this.state.left} right={this.state.right} startOver={this.setBothPossibilities} />
      </div>
    )
  }
});

var Left = React.createClass({
  handleChangeLeft: function() {
    this.props.setLeftPossibility();
  },
  render: function() {
    console.log(this.props.possibility);
     return (
       <div className="left-possibility">
         <div className="col s3 offset-s2 left-possibility">
           <div className="card-content white-text">
             <h3>{this.props.possibility.title}</h3>
             <p>Source: {this.props.possibility.source}</p>
           </div>
           <div className="card-action">
            <button className="waves-effect waves-light light-blue btn dashboard-possibility-button"
                    id="new-possibility-left"
                    onClick={this.handleChangeLeft}>
                    <i className="material-icons left"> replay </i>
                    New possibility
            </button>
            <a className="waves-effect waves-light light-blue btn"><i className="material-icons left">thumb_down</i>Blacklist</a>
           </div>
         </div>
       </div>
     )
  }
});

var Right = React.createClass({
  handleChangeRight: function() {
    this.props.setRightPossibility();
  },
  render: function() {
    return (
      <div className="right-possibility">
         <div className="col offset-s2 s3">
           <div className="card-content white-text">
             <h3>{this.props.possibility.title}</h3>
             <p>Source: {this.props.possibility.source}</p>
           </div>
           <div className="card-action">
            <button className="waves-effect waves-light light-blue btn dashboard-possibility-button"
                    id="new-possibility-right"
                    onClick={this.handleChangeRight}>
                    <i className="material-icons left">
                    replay
                    </i>New possibility
            </button>
            <a className="waves-effect waves-light light-blue btn"><i className="material-icons left">thumb_down</i>Blacklist</a>
           </div>
         </div>
       </div>
    )
  }
});

var Composite = React.createClass({
  handleChangeBothPossibilities: function() {
    this.props.startOver();
  },
  render: function() {
    return (
    <div className="composite">
     <div className="row center">
       <div className="offset-s4 col s4" id="dashboard-combined">
         <h2>{this.props.left.title} {this.props.right.title}</h2>
       </div>
       <div className="s4">
       </div>
     </div>
       <div className="row center">
          <button className="waves-effect waves-light light-blue btn"
                  onClick={this.handleChangeBothPossibilities}>
                  <i className="material-icons left">
                  replay
                  </i>Try again
          </button>
          <a className="waves-effect waves-light light-blue btn"><i className="material-icons left">done</i>Save Idea</a>
        </div>
        <br/><br/><br/><br/><br/><br/><br/><br/><br/>
      </div>
    )
  }
});
