var Profile = React.createClass({
  getInitialState: function() {
    return { currentIdeas: [], ideaPossibilities: [] }
  },
  componentDidMount: function() {
    $.ajax({
      url: "/api/v1/ideas.json",
      type: "GET",
      success: function(response) {
        this.setState({currentIdeas: response})
      }.bind(this)
    });
  },
  onTweetIdea: function(id) {
    $.ajax({
      url: "/api/v1/ideas/" + id + "/tweets.json",
      type: "POST",
      success: function(response) {
       console.log("You just tweeted!");
      }.bind(this)
    });
  },
  onDeleteIdea: function(id) {
    var ideas = this.state.currentIdeas.filter(function(idea) {
      return idea.id != id;
    });

    $.ajax({
      url: "/api/v1/ideas/" + id,
      type: "DELETE",
      success: function(response) {
        this.setState({currentIdeas: ideas})
      }.bind(this)
    });
  },
  render: function() {
    return (
      <div className="jsx-one-time">
        <table className="highlight centered">
         <thead>
           <tr>
             <th>Idea</th>
             <th>Get feedback from followers</th>
             <th>Source 1</th>
             <th>Source 2</th>
             <th>Trash it</th>
           </tr>
         </thead>
          <Ideas ideas={this.state.currentIdeas} tweetIdea={this.onTweetIdea} deleteIdea={this.onDeleteIdea} />
         </table>
       </div>
    )
  }
});

var Ideas = React.createClass({
  handleTweetIdea: function(event) {
    this.props.tweetIdea(event.target.value);
  },
  handleDeleteIdea: function(event) {
    this.props.deleteIdea(event.target.value);
  },
  render: function() {
    var ideas = this.props.ideas.map(function(idea, index) {
      return (
         <tr className="idea" key={"idea-" + index}>
           <td>{idea.composite}</td>
           <td><button className="waves-effect waves-light btn"
                        onClick={this.handleTweetIdea}
                        value={idea.id}
                        >
                        Tweet it
                </button>
           </td>
           {idea.possibilities.map(function(possibility, index){
             return (
              <td className="possibility-one-time" key={"possibility-" + index}>
                {possibility.title}
              </td>
             )
           })
         }
           <td><button className="waves-effect waves-light btn"
                        onClick={this.handleDeleteIdea}
                        value={idea.id}
                      >
                  <i className="material-icons">delete</i>
                </button>
          </td>
         </tr>
      )
    }.bind(this));

    return (
      <tbody className="ideas">
        {ideas}
      </tbody>
    )
  }
});
