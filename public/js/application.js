$(document).ready(function() {
  newQuestionSubmit();
});

var newQuestionSubmit = function() {
  $('.new-question').on('submit', '#new-question-form', function(event) {
    event.preventDefault();
    var questionTitle = $('#new-question-form').find('input').first().val();
    var questionBody = $('#new-question-form').find('textarea').val();
    console.log(questionBody);
    $.ajax({
      method: "post",
      url: "/questions",
      data: {title: questionTitle, body: questionBody}
    }).done(function(newQuestionId) {
      console.log(newQuestionId);
      var newQuestionUrl = "http://localhost:9393/questions/"+newQuestionId.question_id
      console.log(newQuestionId)
      if(newQuestionId != null || newQuestionId != undefined) {
        window.location = newQuestionUrl
      } else{
        window.location = "http://localhost:9393/questions"
      }
    })
  });
}
