$(document).ready(function() {



});

var upVoteButton = function($button){
  if ($button.attr("class") === "upvote" || $button.attr("class") === "upvote on") {
    return true;
  } else {
    return false;
  }
}

var upVote = function($button){
  if ($button.attr("class") === "upvote on"){
    return true;
  } else {
    return false;
  }
}
