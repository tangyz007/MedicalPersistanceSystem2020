class RequestController < ApplicationController
    def request_params
        params.require(:request).permit(:role, :provider_id, :email, :password, :password_check)
    end 
    
    def new
    # @record = current_user     #you now have access to the @user variable in your view
    end

    def show
        
    end
    
    def create

        if request_params["email"] !~ /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
            render html: "<h1>Email is invalid! Please return to previous page to correct! </h1>".html_safe
        elsif Request.find_by(email:request_params["email"]) || User.find_by(email:request_params["email"])
            render html: "<h1>Email has already exist, please wait for approval or use another one. </h1>".html_safe
        elsif request_params["password"].length < 6 || request_params["password"] == nil
            render html: "<h1>Password can't be blank or less than 6 digits, Please return to previous page to correct! </h1>".html_safe
        elsif !(request_params["password"].eql? request_params["password_check"])
            render html: "<h1>Passwords must match. Please return to previous page to correct it. </h1>".html_safe
        else        
            @record = Request.create!(provider_id:request_params["provider_id"],email:request_params["email"],password:request_params["password"])
            @users = User.create!(role:request_params["role"], full_name:request_params["provider_id"], email:request_params["email"],password:request_params["password"])
            redirect_to '/success'
        end
        
    end
end