#---- Landing Page After Login/Signup:  Show ALL User Surveys ----------------

get '/surveys' do
@surveys = Survey.all
erb :"survey_views/display_survey"      #take them to display @ views/survey_views/display_survey.erb
end

#--- Create a Survey Routes ------------------------------------------
get '/survey/new' do
  if session[:user_id] == nil
    redirect '/'
  end
  erb :"survey_views/create_survey"
end

#Create survey session and set it equal to the new survey id
post '/survey/create' do
  @survey = Survey.create(params[:survey])
  holder =  '<input type="hidden" value="<%='+"#{@survey.id}"+'%>" name="survey_id"/>'
end

#For Create Question
post '/survey/create/question' do
  puts "LOG #{params.inspect}"
  @survey = Survey.find(session[:current_survey])
  puts "LOG #{@survey}"
  @survey.questions << Question.new(params[:question])
  @question = Question.last
  puts "LOG #{@question}"
  params.each_pair do |name, answer|
    @question.answer_choices << AnswerChoice.new(text: answer)
    end
  puts "[LOG THIS SHIT] #{params.inspect}"
end


get '/survey/...' do        #once survey is totally completed
  redirect '/surveys'       #send them back to the landing page with ALL surveys
end

#----------Display an individual Survey to the User ----------
get '/survey/:survey_id/individual' do #display_survey.erb sends users to display_one.erb,

  @survey = Survey.find_by_id(params[:survey_id])
  @questions = @survey.questions # array
  # @questions.each {}
  # @answer_choices =
  # @question
  # if @survey == nil
  #   @error = true
  # end

  erb :"survey_views/display_one"
end

#----------- Take a Survey Route ----------------------------------------

#when you click "Take Survey" it uses this route:
get '/survey/:survey_id' do
  @survey = Survey.find(params[:survey_id])
  # @questions = @survey.questions # array
  erb :"survey_views/take_survey"
end

post '/survey/take' do
 # @survey = Survey.find(params[:survey_id])
 @survey = Survey.find_by_id(params[:survey_id])
  @questions = @survey.questions
  #@question = @survey.

  params['answers'].each do |key,value|
    Response.create(
      user: User.find(session[:user_id]),
      question: Question.find(key.to_i),
      answer_choice: AnswerChoice.find(value.to_i)
    )
  end
  redirect to '/confirmation'
end


#redirect user to confirmation page after taking survey:
get '/confirmation' do
  erb :"survey_views/completed_survey"
end

#------------ View a list of YOUR Surveys (not the global list on landing page)

get '/view_your_surveys' do
  # if session[:user_id] == nil
  #   redirect '/'
  # end

  @surveys = User.find(session[:user_id]).surveys
  erb :"survey_views/list_user_surveys"
end

#----------- View the RESULTS of your Surveys ----------------

get '/survey/:survey_id/results' do
  @survey = Survey.find_by_id(params[:survey_id])
  if @survey == nil
    @error = true
  end

  erb :"survey_views/results"
end

# ---------- Delete --------------------

delete '/surveys/:id' do
  survey = Survey.find(params[:id])
  survey.delete
end
