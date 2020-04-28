class ProviderController < ApplicationController
    protect_from_forgery with: :exception
    def provider_params
        params.require(:provider).permit(:name, :email, :password)
    end 
    
    def new
    # @record = current_user     #you now have access to the @user variable in your view
    end
    
    def success
        @record = Request.create!(provider_params)
        # flash[:notice] = "#{@movie.title} was successfully created."
        flash[:notice] = "Your application is successfully submitted."
        redirect_to '/success'
  end
end