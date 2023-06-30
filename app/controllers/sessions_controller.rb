# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :verify_user

  SessionForm = Struct.new(:email, :password)
  def new
    @session_form = SessionForm.new(SessionForm)
  end

  def create

  end

  def destroy

  end
end
