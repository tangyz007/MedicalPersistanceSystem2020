# require Rails.root.join('lib', 'rails_admin_approve.rb')

module RailsAdmin
  module Config
    module Actions
      class Approve < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)
        register_instance_option :visible? do
           true
        end
        register_instance_option :member do
          true
        end
        register_instance_option :link_icon do
          #FontAwesome Icons
          'icon-check'
        end
        register_instance_option :controller do
          Proc.new do
            # Do whatever you want with @object
          end
        end
      end
    end 
  end
end


RailsAdmin.config do |config|
  config.authorize_with do
    config.current_user_method(&:current_user)
    redirect_to main_app.root_path unless current_user.admin == true
  end
  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    
    # Make edit invisible for request model
    edit do 
      except "Request"
    end
    
    delete
    # show_in_app
    
    # Set the custom approve action here
    approve do
      # Make it visible only for request model. You can remove this if you don't need.
      visible do
        bindings[:abstract_model].model.to_s == "Request"
      end
    end

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
