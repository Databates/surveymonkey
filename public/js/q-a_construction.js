// Creating Questions and Answer Choices

$(document).ready( function(){
  var counter = 1;
  // once a user types, radio buttons appear (fixed | open response choice)

  $('input[name="question[text]"]').on('keyup', function() {
    $('#input-options').show().fadeIn( 500 );
  });

  // once a user selects between fixed/open responses, subsequent options appear as dropdowns

  $('input[name=answer-type]').click(function() {
    var responseType = $('input[name=answer-type]:checked').val();
    if (responseType === 'fixed-response') {
      $('#response-fixed-options').show();
      $('#response-free-options').hide();
    }
    else if (responseType === 'free-response') {
      $('#response-free-options').show();
      $('#response-fixed-options').hide();
      $('#user-action-buttons').show();
    }
  });

  // submit a question
  $('#submit-question').click(function () {
    $.post('/survey/create/question', $('#create-question-form').serialize(), function() {
      counter ++;
      var surveyQuestionText = "Survey Question #" + counter;
      $('.question-text').text(surveyQuestionText);
      $('#input-options').hide();
      $('#response-fixed-options').hide();
      $('#response-free-options').hide();
    });
  });
});

