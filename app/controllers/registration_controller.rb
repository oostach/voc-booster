# frozen_string_literal: true

class RegistrationController < ApplicationController
  layout 'session'

  skip_before_action :redirect_not_auth_to_signin
  before_action :redirect_to_user_root

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to signin_path, notice: t('confirmation_message', scope: 'flash.notice')
    else
      render action: :new
    end
  end

  def confirm
    @user = User.find_by(confirmation_token: params[:confirmation_token])
    if @user

    else
      redirect_to signin_path, notice: t('confirmation_incorrect', scope: 'flash.alert')
    end
  end

  private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :middle_name, :date_of_birth)
    end
end
