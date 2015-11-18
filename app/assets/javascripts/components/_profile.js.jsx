var Profile = React.createClass({
  getInitialState: function() {
    return { currentIdeas: [] }
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
    console.log("here")
    $.ajax({
      url: "/api/v1/ideas/" + id + "/tweets.json",
      type: "POST",
      success: function(response) {
       console.log("cake is good");
      }.bind(this)
    });
    console.log("in tweet idea TOP level")
    console.log(id)
  },
  render: function() {
    return (
      <div className="jsx-one-time">
        <h4 className="header center orange-text">Need a little inspiration?</h4>
        <div className="row">
            <div className="input-field offset-s4 col s4">
               <select>
                 <option value="" disabled selected>Choose a category to get started</option>
                 <option value="business">Business idea</option>
                 <option value="product">Product idea</option>
               </select>
               <button className="btn waves-effect waves-light" type="submit" name="action">Go
                 <i className="material-icons right">send</i>
                </button>
           </div>
           <div className="col s4">
           </div>
        </div>

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

         <tbody>
            <Ideas ideas={this.state.currentIdeas} getIdeaPossibilities={this.ideaPossibilities} tweetIdea={this.onTweetIdea} />
          </tbody>
         </table>
       </div>

    )
  }
});

var Ideas = React.createClass({
  handleTweetIdea: function(event) {
    console.log(event)
    this.props.tweetIdea(event.target.value);
  },
  renderIdeaPossibilities: function(id) {
    $.ajax({
      url: "/api/v1/ideas/" + id + "/possibilities",
      type: "GET",
      success: function(response) {
        <div className="idea" key={"idea-" + id}>
         <tbody>
           <tr>
             <td>{idea.id}</td>
             <td><button className="waves-effect waves-light btn"
                          onClick={this.handleTweetIdea}
                          value={idea.id}
                          >
                          Tweet it
                  </button>
             </td>
              {response.map(function(possibility, index) {
                <div className="possibility" key={index}>
                   <td>{possibility.title}</td>
                 </div>
                })
              }
             <td><a className="material-icons">delete</a></td>
           </tr>
         </tbody>
        </div>
      }
    });
  },

  render: function() {
    var ideas = this.props.ideas.map(function(idea, index) {
      return (
         <tr className="idea" key={"idea-" + index}>
           <td>my big idea</td>
           <td><button className="waves-effect waves-light btn"
                        onClick={this.handleTweetIdea}
                        value={idea.id}
                        >
                        Tweet it
                </button>
           </td>
                 <td>source 1</td>
                 <td>source 2</td>
           <td><a className="material-icons">delete</a></td>
         </tr>
      )
    }.bind(this));

    return (
      <div className="ideas">
        {ideas}
      </div>
    )
  }
});
