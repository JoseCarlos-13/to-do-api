# frozen_string_literal: true

# app/use_cases/user/cancel_account.rb
class User::CancelAccount # rubocop:disable Style/ClassAndModuleChildren
  def initialize(user)
    @user = user
  end

  def call
    if @user.tasks.where(status: 'in_development').count.zero?
      inactive_user(@user)
    elsif user.tasks.where(status: 'in_development').count != 0
      inactive_user(@user) && cancel_tasks(@user)
    end
  end

  private

  attr_accessor :user

  def inactive_user(user)
    user.update(status: 'inactive')
  end

  def cancel_tasks(user)
    user.tasks.where(status: 'in_development').update_all(status: 'cancelled')
  end
end
