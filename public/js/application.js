$(document).ready(function() {
  newQuestionButtonClickEvent();
  newQuestionSubmit();
  newQuestionCommentButtonClickEvent();
});
// Functions
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
    $('.question-comments').toggle();
  });
}

var newQuestionCommentSubmit = function() {
  $('.question-comments').on('submit', '.new-comment-form', function(){
    event.preventDefault();
    var commentType = 'question'
    var questionCommentBody = $('#new-comment-form').find('textarea').val();
    $.ajax({
      method: "post",
      url: "/comments",
      data: {body: questionCommentBody, comment_type: commentType}
    }).done(function(newCommentObject) {

    }).fail(function(errors){
      alert("Comment body can't be blank")
    })
  });
}
