class WelcomeController < ApplicationController

  def home
  end

  def admin_dashboard
    authorize(:dashboard, :is_admin?)
    @user_count = User.count
  end

end
