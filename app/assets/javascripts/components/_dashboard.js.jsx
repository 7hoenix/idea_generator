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
    this.setState({left: this.nextPossibility()});
  },
  setRightPossibility: function() {
    this.setState({right: this.nextPossibility()});
  },
  setBothPossibilities: function() {
    $.ajax({
      url: "/api/v1/possibilities.json",
      type: "GET",
      data: { idea_type: "business" },
      success: function(response) {
        this.setState({possibilities: response});
        this.setLeftPossibility();
        this.setRightPossibility();
      }.bind(this)
    });
  },
  blackListLeft: function(possibility_id) {
    this.blackList(possibility_id);
    this.setLeftPossibility();
  },
  blackListRight: function(possibility_id) {
    this.blackList(possibility_id);
    this.setRightPossibility();
  },
  blackList: function(possibility_id) {
    console.log(possibility_id);
    $.ajax({
      url: "/api/v1/lists.json",
      type: "POST",
      data: { possibility: {possibility_id: possibility_id, type: "black" } },
      success: function(response) {
        console.log("cake");
      }.bind(this)
    });
  },
  leftSpinner: function() {
        <div className="preloader-wrapper big active">
     <div className="spinner-layer spinner-blue-only">
       <div className="circle-clipper left">
         <div className="circle"></div>
       </div><div className="gap-patch">
         <div className="circle"></div>
       </div><div className="circle-clipper right">
         <div className="circle"></div>
       </div>
     </div>
    </div>
  },
  rightSpinner: function() {
        <div className="preloader-wrapper big active">
     <div className="spinner-layer spinner-blue-only">
       <div className="circle-clipper left">
         <div className="circle"></div>
       </div><div className="gap-patch">
         <div className="circle"></div>
       </div><div className="circle-clipper right">
         <div className="circle"></div>
       </div>
     </div>
    </div>
  },
  saveOrLogin: function() {
    this.saveIdea();
  },
  saveIdea: function() {
    $.ajax({
      url: "/api/v1/ideas.json",
      type: "POST",
      data: { idea: {possibility_alpha_id: this.state.left.id, possibility_beta_id: this.state.right.id} },
      success: function(response) {
        if (response === true){
          window.location.replace("/profile");
        }
      }.bind(this),
      error: function(response) {
        window.location.replace("/auth/twitter");
        console.log(response);
        console.log("could not login");
      }
    });
  },
  render: function() {
    return (
      <div className="section" id="dashboard-body">
        <div className="row center dashboard-card-vertical">
           <Left possibility={this.state.left} leftSpinner={this.state.leftSpinner} setLeftPossibility={this.setLeftPossibility} blackListLeft={this.blackListLeft} />
           <Right possibility={this.state.right} rightSpinner={this.state.rightSpinner} setRightPossibility={this.setRightPossibility} blackListRight={this.blackListRight} />
         <div className="col s2">
         </div>
       </div>
       <br/>
        <Composite left={this.state.left} right={this.state.right} startOver={this.setBothPossibilities} saveOrLogin={this.saveOrLogin} />
      </div>
    )
  }
});

var Left = React.createClass({
  handleChangeLeft: function() {
    this.props.setLeftPossibility();
  },
  handleBlackListLeft: function(event) {
    event.preventDefault();
    var possibility = React.findDOMNode(this.refs.possibilityTitle).id

    this.props.blackListLeft(possibility);
  },
  render: function() {
     return (
       <div className="left-possibility">
         <div className="col s3 offset-s2 left-possibility">
           <div className="card-content white-text">
             <h3 ref="possibilityTitle" id={this.props.possibility.id}>{this.props.possibility.title}</h3>
             <p>Source: {this.props.possibility.source}</p>
           </div>
           <div className="card-action">
            <button className="waves-effect waves-light light-blue btn dashboard-possibility-button"
                    id="new-possibility-left"
                    onClick={this.handleChangeLeft}>
                    <i className="material-icons left"> replay </i>
                    New possibility
            </button>
            <button className="waves-effect waves-light light-blue btn"
              id="black-list-left"
              onClick={this.handleBlackListLeft}
              value={this.props.possibility}
              >
              <i className="material-icons left"
              > thumb_down</i>
              Blacklist
              </button>
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
  handleBlackListRight: function(event) {
    event.preventDefault();
    var possibility = React.findDOMNode(this.refs.possibilityTitle).id

    this.props.blackListRight(possibility);
  },
  render: function() {
    return (
      <div className="right-possibility">
         <div className="col offset-s2 s3">
           <div className="card-content white-text">
             <h3 ref="possibilityTitle" id={this.props.possibility.id}>{this.props.possibility.title}</h3>
             <p>Source: {this.props.possibility.source}</p>
           </div>
           <div className="card-action">
            <button className="waves-effect waves-light light-blue btn dashboard-possibility-button"
                    id="new-possibility-right"
                    onClick={this.handleChangeRight}
                    value={this.props.possibility}
                    >
                    <i className="material-icons left">
                    replay
                    </i>New possibility
            </button>
            <button className="waves-effect waves-light light-blue btn"
              id="black-list-right"
              onClick={this.handleBlackListRight}>
              <i className="material-icons left">thumb_down</i>
              Blacklist
              </button>
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
  handleSaveLoginButton: function() {
    this.props.saveOrLogin();
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
          <button className="waves-effect waves-light light-blue btn"
                  onClick={this.handleSaveLoginButton}
              >
                <i className="material-icons left">
                done
                </i>
                Save Idea
          </button>
        </div>
        <br/><br/><br/><br/><br/><br/><br/><br/><br/>
      </div>
    )
  }
});
