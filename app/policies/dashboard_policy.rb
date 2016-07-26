class DashboardPolicy < Struct.new(:user, :dashboard)
  def is_admin?
    user and user.admin?
  end
end