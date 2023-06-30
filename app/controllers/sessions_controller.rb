# frozen_string_literal: true

class SessionsController < ApplicationController
  layout 'session'
  skip_before_action :verify_user
  def new
    @signin_form = SigninForm.new
  end

  def create
    @signin_form = SigninForm.new(signin_params)

    if @signin_form.valid?
      sign_in @signin_form.user
      redirect_to root_path, notice: 'Welcome back!'
    else
      render action: :new
    end
  end

  def destroy

  end

  private

    def signin_params
      params.require(:signin_form).permit(:email, :password)
    end
end
