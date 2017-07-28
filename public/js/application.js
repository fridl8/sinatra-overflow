$(document).ready(function() {
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
    })
  });
});
