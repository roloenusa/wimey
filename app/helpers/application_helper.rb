module ApplicationHelper
  
  def get_user(user_id)
    user_id.nil? || user_id.to_i == current_user.id ? current_user : User.find_by_id(user_id)
  end
end
