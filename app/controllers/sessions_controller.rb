# frozen_string_literal: true

class SessionsController < ApplicationController
  layout 'session'
  skip_before_action :redirect_not_auth_to_signin, only: %i[new create]
  before_action :redirect_to_user_root, only: %i[new create]

  def new
    @signin_form = SigninForm.new
  end

  def create
    @signin_form = SigninForm.new(signin_params)

    if @signin_form.valid?
      sign_in @signin_form.user
      redirect_to_user_root(with_message: 'Welcome back!')
    else
      render action: :new
    end
  end

  def destroy
    sign_out
  end

  private

    def signin_params
      params.require(:signin_form).permit(:email, :password)
    end
end
