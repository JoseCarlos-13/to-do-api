# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    users = User.all

    render json: users, status: :ok
  end

  # modificar a action para cancel_account
  # 
  def cancel_account
    @user = User.find(params[:id])
# renomear o usecase para algo que represente o usecase. Por exemplo: Users::CancelAccount
    User::CancelAccount.new(@user).call
  end

  private

  def user_params
    params.permit(:name, :status)
  end
end
