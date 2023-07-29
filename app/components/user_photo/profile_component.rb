# frozen_string_literal: true

class UserPhoto::ProfileComponent < ApplicationComponent
  delegate :photo, :first_name, :last_name, to: :@user
  delegate :image_tag, to: :helpers

  attr_reader

  def initialize(user:)
    @user = user
  end

  def initials
    first_name.at(0) + last_name.at(0)
  end

  def size
    :full
  end
end
