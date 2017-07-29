$(document).ready(function() {
  newQuestionButtonClickEvent();
  newQuestionSubmit();
  newQuestionCommentButtonClickEvent();
  newQuestionCommentSubmit();
  submitAnswerFromForm();
  voteClickEvent();
  newAnswerCommentSubmit();
  newAnswerCommentButtonClickEvent();
});
// Functions
  var submitAnswerFromForm = function () {
  	$(".answer_form").on("submit", function(event){
    event.preventDefault();
    var question_route= $(this).attr("action");
    var formData = {body: $(event.target).find('textarea').val()};
    var response = $.ajax({
      url : question_route,
      method : "POST",
      data : formData
    });
    response.done(function(data){
      $(event.target).find('textarea').val("")
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

var voteClickEvent = function(){
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

var newAnswerCommentButtonClickEvent = function() {
  $('.answer').on('click', "#toggle-a-comment-form", function(event) {
    event.preventDefault();
    $(event.target).parent().find(".answer-comment-form").toggle();
    $(event.target).toggle();
  });
}

var newAnswerCommentSubmit = function() {
  $(".answer-comment-form").on("submit", "#new-comment-form", function(event) {
    event.preventDefault();

    var $formData = $(event.target);
    var url = $formData.attr("action");
    var type = $formData.attr("method");

    var commentType = 'answer';
    var answerCommentBody = $(event.target).find('textarea').val();
    var commentAnswerId = $(event.target).parent().closest('.answer').find('p').first().attr('data-answer-id');
    var request = $.ajax({
      url: url,
      method: type,
      data: {body: answerCommentBody, comment_type: commentType, current_answer_id: commentAnswerId}
    })
    request.done(function(response) {
      $(event.target).parent().toggle();
    $(event.target).parent().parent().find('#toggle-a-comment-form').toggle();
      $(event.target).parent().find('#toggle-a-comment-form').toggle();
      $(event.target).find('textarea').val("")
      $(event.target).parent().closest('.answer').parent().find('div').first().find('.answer-comments').append(response);
    })
  })
}
