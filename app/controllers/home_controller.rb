class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    if current_user.role == "admin"
      redirect_to '/admin'
    elsif current_user.role == "provider"
      redirect_to '/provider/index'
    elsif current_user.role == "patient"
      redirect_to '/patient/index'
    end
    # else
    #   redirect_to user_session_path
    # if current_user.admin == true
    #   redirect_to '/admin'
    # elsif  current_user.provider == false
    #   redirect_to '/users/sign_out/'
    # end
    # initialize_search
    # handle_search_name

    session[:search_name] ||= params[:search_name]
    if session[:search_name]
      @questions = Question.where(user_id: current_user.id)
      # @questions = Question.where("name LIKE ?", "%#{session[:search_name]}%")
      @questions = @questions.where("lower(name) LIKE ?", "%#{session[:search_name]}%".downcase)
      session[:search_name] = nil    
            # @teams = @teams.where(code: @players.pluck(:team))
    else
      @questions = Question.where(user_id: current_user.id)
    end
    # @questions = Question.where(user_id: current_user.provider_id)
   
  end
    
  def initialize_search
    @questions = Question.where(user_id: current_user.provider_id)     #alphabetical
    session[:search_name] ||= params[:search_name]
      # session[:filter] = params[:filter]
      # params[:filter_option] = nil if params[:filter_option] == ""
      # session[:filter_option] = params[:filter_option]
  end
  
  def handle_search_name
    if session[:search_name]
      @questions = Question.where("name LIKE ?", "%#{session[:search_name].titleize}%")
          
            # @teams = @teams.where(code: @players.pluck(:team))
    else
      @questions = Question.where(user_id: current_user.provider_id)
    end
  end
  
end
