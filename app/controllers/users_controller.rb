class UsersController < ApplicationController
  skip_before_action :authorize_request, only: :create
  # POST /sign_up
  # return authenticated token upon signup
  def create
    user = User.create!(user_params)
    auth_token = AuthenticateUser.new(user.email, user.password).call
    response = { message: Message.account_created, auth_token: auth_token }
    json_response(response, :created)
  end

  def edit
    account_info = current_user.get_account_info
    json_response(account_info)
  end

  def update
    if current_user.authenticate(params[:current_password])
      current_user.first_name = params[:first_name]
      current_user.last_name = params[:last_name]
      current_user.email = params[:email]
      current_user.password = params[:password] if !current_user.authenticate(params[:password])
      current_user.password_confirmation = params[:password_confirmation] if !current_user.authenticate(params[:password_confirmation])

      if current_user.save
        json_response(current_user.get_account_info)
      else
        message = current_user.errors.full_messages
        json_response({ message: message })
      end
    else
      json_response({ message: [Message.invalid_credentials] })
    end
  end

  private

  def user_params
    params.permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation
    )
  end
end
