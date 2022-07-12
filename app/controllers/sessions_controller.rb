class SessionsController < ApplicationController
    skip_before_action :authenticate_user, only: [:create]

    def create
        user = User.find_by(username: params[:username])
        if user&.authenticate(params[:password])
          session[:user_id] = user.id
          render json: user, status: :created
        else
          render json: { error: {login: "Invalid username or password"} }, status: :unauthorized
        end
    end

  # DELETE '/logout'
  def destroy
    if current_user
      session.clear
    else
      render json: { errors: "No active session" }, status: :unauthorized
    end
  end

    # def destroy
    #     user = User.find(params[:user_id])
    #     byebug
    #     user.destroy
    #     if user.valid?
    #       session[:user_id] = user.id
    #       render json: user, status: :created
    #     else
    #       render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    #     end
    # end
end
