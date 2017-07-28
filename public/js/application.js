$(document).ready(function() {

  newQuestionButtonClickEvent();
  newQuestionSubmit();
  submitAnswerfromForm();
  vote();

});

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
          // DELETE VOTE
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
          // DELETE VOTE
      }
    }

      var response = $.ajax({
        url : "/questions/" + question_id + "/votes",
        method : "POST",
        data : vote_data
      });

      response.done(function(data){
        console.log(data);
      })
    });
}

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
