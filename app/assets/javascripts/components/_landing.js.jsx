var Landing = React.createClass({
  getInitialState: function() {
    return { left: [] }
  },
  optionSubmit: function(ideaType) {
      console.log(ideaType)
  },
  render: function() {
    return (
      <div className="section no-pad-bot" id="index-banner">
        <div className="container">
          <div className="section">
          </div>
          <div className="section">
          </div>
          <br/><br/>
          <h1 className="header center orange-text">Need a little inspiration?</h1>
          <div className="row">
          <OptionSelect optionSubmit={this.optionSubmit} />
           <div className="col s2">
           </div>
          </div>
        </div>
      </div>
    )
  }
});

var OptionSelect = React.createClass({
  handleOptionSubmit: function() {
    window.location.replace("/dashboard");
  },
  render: function() {
     return (

<div className="big-div">

      <div className="input-field offset-s2 col s8">
         <select>
           <option value="" disabled selected>Choose a category to get started</option>
           <option value="business">Business idea</option>
           <option value="product">Product idea</option>
         </select>
        <label>We pull ideas from top trending websites and mash them together.</label>
         <button className="btn waves-effect waves-light"
                 onClick={this.handleOptionSubmit}
                 value={$("input.select-dropdown").val()}
                 name="action">
                 Go
           <i className="material-icons right">send</i>
          </button>
       </div>
       </div>
     )
   }
});
