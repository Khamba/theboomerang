class WelcomeController < ApplicationController

  def home
  end

  def admin_dashboard
    @user_count = User.count
  end

end
