class Users::RegistrationsController < Devise::RegistrationsController
# before_filter :configure_sign_up_params, only: [:create]
# before_filter :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    super
    # draw links to the user
    @user = User.find_by_email(params[:user][:email])
    puts "#{params[:user][:major]}"
    params[:user]["major"].each do |major_id|
        if !major_id.empty?
            @user.major << Major.find(major_id)
        end
    end
    puts "#{params[:user][:minor]}"
    params[:user]["minor"].each do |minor_id|
        if !minor_id.empty?
            @user.minor << Minor.find(minor_id)
        end
    end
    puts "#{params[:user][:concentration]}"
    params[:user]["concentration"].each do |concentration_id|
        if !concentration_id.empty?
            @user.concentration << Concentration.find(concentration_id)
        end
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.for(:sign_up) << :attribute
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.for(:account_update) << :attribute
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
