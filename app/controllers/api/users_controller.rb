module Api
  class UsersController < ApplicationController
    respond_to :json

    def show
      user = User.find(params[:id])
      render json: user
    end

    def current
      if current_user
        render json: current_user
      else
        render nothing: true, status: :not_found
      end
    end

    def change_password
      if !current_user.authenticate(params[:current_password]) then
        return render json: {:message => 'Current password is invalid'}
      end
      if params['password'] != params[:password_confirmation]
        return render json: {:message => 'New password & Confirm password mismatch'}
      end
      current_user.update_password(params[:password])
      current_user.save(:validate => false)
      return render json: {}
    end

  end
end