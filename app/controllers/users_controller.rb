class UsersController < ApplicationController
    wrap_parameters format: []
    #skip_before_action :authenticate_user, only: [:create, :show]
    skip_before_action :authenticate_user, only: [:create]

    def show
      user = User.find(session[:user_id])
      #user = current_user
      if user.valid?
          #session[:user_id] = user.id
          render json: user, status: :ok
      else
          render json: { errors: user.errors.full_messages }, status: :unauthorized
      end
    end
    #{ "username": "steven", "password": "un1verse" }

    def create
        user = User.create!(user_params)
        if user.valid?
          session[:user_id] = user.id
          render json: user, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
    end
    
    private
    
    def user_params
        params.permit(:username, :password, :password_confirmation)
        #params.permit(:username, :password)
    end
end
