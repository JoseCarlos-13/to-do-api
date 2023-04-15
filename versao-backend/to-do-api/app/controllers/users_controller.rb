# frozen_string_literal: true

# users_controller
class UsersController < ApplicationController
  def index
    users = User.all

    render json: users, status: :ok
  end

  def cancel_account
    @user = User.find(params[:id])
    User::CancelAccount.new(@user).call
  end

  private

  def user_params
    params.permit(:name, :status)
  end
end
