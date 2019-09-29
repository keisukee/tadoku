module FlashHelper
  def flash_class(message_type)
    case message_type
    when "notice"
      "info"
    when "success"
      "success"
    when "danger"
      "danger"
    when "warning"
      "warning"
    else
      "notification"
    end
  end
end
