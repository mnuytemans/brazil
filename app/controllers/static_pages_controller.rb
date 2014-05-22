class StaticPagesController < ApplicationController
  before_action :signed_in_user, only: [:home]

  def home

  end

  def help
  end

  def about
  end

  def contact
  end

  private

  def signed_in_user
    if signed_in?
      redirect_to user_path(current_user.id)
    end
  end


end
