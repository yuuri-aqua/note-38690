class HomesController < ApplicationController
  # before_action :move_to_mypage, only: :index
    
  def index
  end

  private
  def move_to_mypage
    if user_signed_in?
      redirect_to posts_path
    end
  end

end
