var Confirm = React.createClass({
  getInitialState: function() {
    return { possibilities: [] };
  },
  componentDidMount: function() {
    this.getPossibilities();
  },
  getPossibilities: function() {
    $.ajax({
      url: "/api/v1/current_idea.json",
      type: "GET",
      success: function(response) {
        this.setState({possibilities: response});
      }.bind(this)
    });
  },
  saveIdea: function() {
    $.ajax({
      url: "/api/v1/ideas.json",
      type: "POST",
      data: { idea: { possibility_alpha_id: this.state.possibilities[0].id, possibility_beta_id: this.state.possibilities[1].id } },
      success: function(response) {
        if (response === true){
          window.location.replace("/profile");
        }
      }.bind(this)
    });
  },
  render: function() {
    return (
      <div className="section" >
        <div className="row center dashboard-card-vertical">
          <h3>Your current idea is:</h3>
          <table className="highlight centered">
            <tr className="center-text">
            {this.state.possibilities.map(function(possibility, index) {
              return (
                <td className="possibility" key={"possibility-" + index}>
                  {possibility.title}
                </td>
              )
            })
            }
            </tr>
          </table>
          <button className="waves-effect waves-light light-blue btn"
            onClick={this.saveIdea}
            >
            <i className="material-icons left"
            >done </i>
            Save Idea
            </button>
         <div className="col s2">
         </div>
       </div>
       <br/>
      </div>
    )
  }
});
