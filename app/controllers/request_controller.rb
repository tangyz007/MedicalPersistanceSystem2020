class RequestController < ApplicationController
    def request_params
        params.require(:request).permit(:provider_id, :email, :password)
    end 
    
    def new
    # @record = current_user     #you now have access to the @user variable in your view
    end

    def show
        
    end
    
    def create
        @record = Request.create!(request_params)
        # flash[:notice] = "#{@movie.title} was successfully created."
        flash[:notice] = "Your application is successfully submitted."
        redirect_to root_path
    end
end