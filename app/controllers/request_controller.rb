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
        # insert into provider application table
        @record = Request.create!(request_params)
        
        # @record = User.create!(admin:0,email:"test@123.com",password:"123123",provider_id:"Tim")
        
        # insert into user table while putting boolean ADMIN and PROVIDER false since its not approved yet
        @users = User.create!(admin:0,provider:0,email:request_params["email"],provider_id:request_params["provider_id"],password:request_params["password"])
        
        flash[:notice] = "Your application is successfully submitted."
        redirect_to root_path
    end
end