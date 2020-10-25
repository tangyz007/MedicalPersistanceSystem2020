class PatientController < ApplicationController
  def index
    @questions = Question.all
  end
  
end
