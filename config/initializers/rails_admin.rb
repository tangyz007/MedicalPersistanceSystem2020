
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
            provider = Request.find_by(id: request.params["id"])
            provider_email = provider.email
            user = User.find_by(email:provider_email)
            user.update(provider: true)
            provider.destroy
 
            flash[:success] = "#{@model_config.label} successfully approved."
 
            redirect_to "/admin/request"
          end
        end
      end
    end 
  end
end

module RailsAdmin
  module Config
    module Actions
      class BulkApprove < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)
        register_instance_option :visible? do
           true
        end
        register_instance_option :bulkable? do
          true
        end
        # register_instance_option :collection do
        #   true
        # end
        
        # register_instance_option :http_methods do
        #   [:delete,:post]
        # end
        
        register_instance_option :controller do
          Proc.new do
            # Do whatever you want with @object
            # Get all selected rows
            @objects = list_entries(@model_config, :create)
            
            # Do the update for each
            @objects.each do |object|
              # object.update_attribute(:published, true)
              provider = Request.find_by(id: request.params["bulk_ids"])
              provider_email = provider.email
              user = User.find_by(email:provider_email)
              user.update(provider: true)
              provider.destroy
            end
 
            flash[:success] = "#{@model_config.label} successfully approved."
 
            redirect_to "/admin/request"


          end
        end
      end
    end 
  end
end



module RailsAdmin
  module Config
    module Actions
      class Disapprove < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :member do
          true
        end

        register_instance_option :route_fragment do
          'delete'
        end

        register_instance_option :http_methods do
          [:get, :delete]
        end

        register_instance_option :authorization_key do
          :destroy
        end

        register_instance_option :controller do
          Proc.new do
            if request.get? # DELETE

              respond_to do |format|
                format.html { render @action.template_name }
                format.js   { render @action.template_name, layout: false }
              end

            elsif request.delete? # DESTROY
              provider = Request.find_by(id: request.params["id"])
              provider_email = provider.email
              user = User.find_by(email:provider_email)
              if user
                user.destroy
              end
              redirect_path = nil
              @auditing_adapter && @auditing_adapter.delete_object(@object, @abstract_model, _current_user)
              if @object.destroy
                flash[:success] = t('admin.flash.successful', name: @model_config.label, action: t('admin.actions.delete.done'))
                redirect_path = index_path
              else
                flash[:error] = t('admin.flash.error', name: @model_config.label, action: t('admin.actions.delete.done'))
                redirect_path = back_or_index
              end

              redirect_to redirect_path

            end
          end
        end

        register_instance_option :link_icon do
          'icon-remove'
        end
      end
    end
  end
end


module RailsAdmin
  module Config
    module Actions
      class BulkDisapprove < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :collection do
          true
        end

        register_instance_option :http_methods do
          [:post, :delete]
        end

        register_instance_option :controller do
          Proc.new do
            # Do whatever you want with @object
            # Get all selected rows
            @objects = list_entries(@model_config, :destroy)
            
            # Do the update for each
            @objects.each do |object|
              # object.update_attribute(:published, true)
              provider = Request.find_by(id: request.params["bulk_ids"])
              provider_email = provider.email
              user = User.find_by(email:provider_email)
              if user
                user.destroy
              end
              provider.destroy
            end
 
            flash[:success] = "#{@model_config.label} successfully disapproved."
 
            redirect_to "/admin/request"
          end
        end
        
        register_instance_option :authorization_key do
          :destroy
        end

        register_instance_option :bulkable? do
          true
        end
      end
    end
  end
end


RailsAdmin.config do |config|
  config.authorize_with do
    config.current_user_method(&:current_user)
    redirect_to main_app.root_path unless current_user.role == "admin"
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
    new do 
      except "Request"
    end
    export
    bulk_delete do
      except "Request"
    end
    # bulk_approve do 
    #   only "Request"
    # end
    # bulk_disapprove do 
    #   only "Request"
    # end
    bulk_approve do
      # Make it visible only for request model. You can remove this if you don't need.
      visible do
        bindings[:abstract_model].model.to_s == "Request"
      end
    end
    
    bulk_disapprove do
      # Make it visible only for request model. You can remove this if you don't need.
      visible do
        bindings[:abstract_model].model.to_s == "Request"
      end
    end
    
    show
    
    # Make edit invisible for request model
    edit do 
      except "Request"
    end
    

    delete do 
      except "Request"
    end
    # show_in_app
    
    # Set the custom approve/disapprove action here
    # Minor Bug with disapprove, so hide these buttons, only show bulk approve/disapprove
    # approve do
    #   # Make it visible only for request model. You can remove this if you don't need.
    #   visible do
    #     bindings[:abstract_model].model.to_s == "Request"
    #   end
    # end
    
    # disapprove do
    #   # Make it visible only for request model. You can remove this if you don't need.
    #   visible do
    #     bindings[:abstract_model].model.to_s == "Request"
    #   end
    # end


    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end

RailsAdmin.config do |config|
  config.model User do
    list do
      field :admin
      field :provider
      field :email
      field :reset_password_sent_at
      field :created_at
      field :updated_at
      field :provider_id 
    end
  end
end
