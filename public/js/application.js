$(document).ready(function() {

  newQuestionButtonClickEvent();
  newQuestionSubmit();
  newQuestionCommentButtonClickEvent();
  newQuestionCommentSubmit();
  submitAnswerfromForm();
  vote();
});
// Functions
  var submitAnswerfromForm = function () {
  	$(".answer_form").on("submit", function(event){
    event.preventDefault();
    var question_route= $(this).attr("action");
    var formData = $(this).serialize();
    var response = $.ajax({
      url : question_route,
      method : "POST",
      data : formData
    });
    response.done(function(data){
      console.log(data);
      $(".answer_container").append(data);
    });

    response.fail(function(){
      alert("Invalid answer.");
    });
  });
}

var newQuestionButtonClickEvent = function() {
  $('#toggle-question-form').on("click", function(event) {
    event.preventDefault();
    $(event.target).toggle();
    $(".new-question").toggle();
  });
}

var newQuestionSubmit = function() {
  $('.new-question').on('submit', '#new-question-form', function(event) {
    event.preventDefault();
    var questionTitle = $('#new-question-form').find('input').first().val();
    var questionBody = $('#new-question-form').find('textarea').val();
    $.ajax({
      method: "post",
      url: "/questions",
      data: {title: questionTitle, body: questionBody}
    }).done(function(newQuestionId) {
      var newQuestionUrl = "http://localhost:9393/questions/"+newQuestionId.question_id
        window.location = newQuestionUrl
    }).fail(function(errors){
      alert("Title or body can't be blank");
    })
  });
}

var newQuestionCommentButtonClickEvent = function() {
  $('#toggle-q-comment-form').on('click', function(event) {
    event.preventDefault();
    $(event.target).toggle();
    $('.question-comment-form').toggle();
  });
}

var newQuestionCommentSubmit = function() {
  $('.question-comment-form').on('submit', '#new-comment-form', function(){
    event.preventDefault();
    var commentType = 'question'
    var questionCommentBody = $('#new-comment-form').find('textarea').val();
    var commentQuestionId = $("#new-comment-form").find("input").first().val();
    $.ajax({
      method: "post",
      url: "/comments",
      data: {body: questionCommentBody, comment_type: commentType, current_question_id: commentQuestionId}
    }).done(function(newCommentInfoObject) {
      $('#toggle-q-comment-form').toggle();
      $('.question-comment-form').toggle();
      $('.question-comments').append(newCommentInfoObject);
    }).fail(function(){
      alert("Comment body can't be blank");
    })
  });
}

  var vote = function(){
    $('.vote_buttons').on('click', function(event){
      $button = $(event.target);
      var question_id = $(this).attr("id");
      if ($button.attr("class") === "upvote" || $button.attr("class") === "upvote on") {
        var $otherButton =  $button.parent().find(".downvote");
        $otherButton.removeClass("on");
        $button.toggleClass('on');
        if ($button.attr("class") === "upvote on") {
          console.log("VOTE UP!");
          var vote_data = {
            'vote' : 1
          };
        } else {
          console.log("DELETE VOTE!");
          var vote_data = {
            'vote' : 0
          };
        }
      } else {
        var $otherButton =  $button.parent().find(".upvote");
        $otherButton.removeClass("on");
        $button.toggleClass('on');
        if ($button.attr("class") === "downvote on") {
          console.log("VOTE DOWN!");
          var vote_data = {
            'vote' : -1
          };
        } else {
          console.log("DELETE VOTE!");
          var vote_data = {
            'vote' : 0
          };
      }
    }

      var response = $.ajax({
        url : "/questions/" + question_id + "/votes",
        method : "POST",
        data : vote_data
      });

      response.done(function(data){
        console.log(data);
        $('.vote_buttons').find(".vote_count").text(data)
      })
    });
  }
