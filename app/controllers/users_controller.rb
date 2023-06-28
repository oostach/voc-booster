# frozen_string_literal: true

class UsersController < ApplicationController
  layout 'session'
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
  end

  private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name)
    end
end
