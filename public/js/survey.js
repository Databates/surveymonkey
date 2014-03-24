$(document).ready( function(){
  // Creating a Survey's Title and Description (with blank-field validations included)
  $('#add-question-button').on("click", function(event) {
    event.preventDefault();
    var surveyTitle = $('#create-survey-form input[name="survey[title]"]').val();
    var surveyDescription = $('#create-survey-form input[name="survey[description]"]').val();
    if (surveyTitle == "") {
      $('#create-survey-validations').text("The Survey Title cannot be blank.").show().fadeOut( 2500 );
    }
    else if (surveyDescription == "") {
      $('#create-survey-validations').text("The Survey Description cannot be blank.").show().fadeOut( 2500 );
    }
    else {
      $.post('/survey/create', $('#create-survey-form').serialize(), function(event) {
        $('#create-survey-form').hide();
        var surveyTitleTag = "<h2 style='color:#008cba'>"+surveyTitle+"</h3>"
        var surveyDescripTag = "<h5 style='color:#008cba'>"+surveyDescription+"</h4>"
        $(surveyDescripTag).prependTo('#create-question-form');
        $(surveyTitleTag).prependTo('#create-question-form');
        $(surveyTag).appendTo('#create-question-form');
        $('#question-text').show().fadeIn( 500 );
      });
    }
  });
});
