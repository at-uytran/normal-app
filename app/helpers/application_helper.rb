module ApplicationHelper
  def alert_class type
    return unless type
    html_class = case type&.to_sym
    when :error
      return "alert-danger"
    when :success
      return "alert-success"
    when :notice
      return "alert-info"
    end
    html_class
  end
end
