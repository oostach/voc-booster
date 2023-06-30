# frozen_string_literal: true

class SessionsController < ApplicationController
  layout 'session'
  skip_before_action :verify_user
  def new
    @signin_form = SigninForm.new
  end

  def create

  end

  def destroy

  end
end
