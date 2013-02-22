Comments = new Meteor.Collection( "comments" )

if Meteor.is_client
  Template.comments.comments = -> Comments.find( {parent_id: null}, { sort: { rating: -1, created_at: 1 }, limit: 5 } )

  Template.comments.events =
    'submit #new_comment': (event) ->
      event.preventDefault()
      Comments.insert( { from: $('#new_comment_from').val(), text: $('#new_comment_text').val(), created_at: (new Date).getTime() } )
      $( "#new_comment_text" ).val( '' )

  Template.comment.events =
    'click .vote-up':   -> Comments.update( this._id, $inc: ( rating: 1 ) )
    'click .vote-down': -> Comments.update( this._id, $inc: ( rating: -1 ) )

