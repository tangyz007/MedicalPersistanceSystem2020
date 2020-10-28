class PatientController < ApplicationController
  before_action :authenticate_user!
  def index
    @questions = Question.where(patient_id: current_user.id)
  end
  
end
