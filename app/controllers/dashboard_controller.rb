# frozen_string_literal: true

class DashboardController < ApplicationController
  def show
    flash.now[:notise] = 'Test Dashboard'
  end
end
