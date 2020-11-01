class ProviderController < ApplicationController
  before_action :authenticate_user!
  def index
    @questions = Question.where(user_id: current_user.id)
  end
  
  def edit_feedback
    # Load JSON file with counselling points
    counsellingPointsFile = File.read('config/counsel_points.json')
    @counsel_points = JSON.parse(counsellingPointsFile)
    
    # Get the row id from URL
    @patient = Question.find(params[:format].to_i)
    
    # Readiness stage
    if @patient.question6 == 1
      @User_stage = 1
      @stage = "stage1"
    elsif @patient.question6 == 2 or @patient.question6 == 3
      @User_stage = 2
      @stage = "stage2"
    elsif @patient.question6 == 4 or @patient.question6 == 5
      @User_stage = 3
      @stage = "stage3"
    elsif @patient.question6 == 6
      @User_stage = 4
      @stage = "stage4"
    end
    
    # Age polarity
    @User_age = @patient.age >= 70 ? "+" : "-"
    # Lower Risk of fracturing polarity
    @User_risk = (@patient.question2 == 4 or @patient.question2 == 5) ? "-" : "+"
    # Inadequate Literacy Polarity
    @User_literacy = (@patient.question3 == 4 or @patient.question3 == 5) ? "-" : "+"
    # Not Received Medication Information in Past Year
    @User_priorinfo = @patient.question4 == true ? "-" : "+"
    # Lower Trust for Medication polarity
    trust_score = (@patient.question51 + @patient.question52 + \
                    @patient.question53 + @patient.question54 + \
                    @patient.question55 + @patient.question56) / 6
    # opinion_score = opinion_total / 6
    @User_trust = trust_score > 3.17 ? "+" : "-"
  end
end
