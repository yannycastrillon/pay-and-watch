module ApplicationHelper

  # In charged of managing the look-and-feel of class messages
  def flash_class(level)
    case level.to_sym
      when :notice then "alert alert-info"
      when :success then "alert alert-success"
      when :error then "alert alert-danger"
      when :alert then "alert alert-warning"
    end
  end

  # Be able to use this method as helper on the views.
  def is_admin?
    !!current_user.admin if !!current_user
  end
end
