class PatientController < ApplicationController
  def index
    @questions = Question.where(patient_id: current_user.id)
  end
  
end
