class ApplicationController < ActionController::Base
  before_action :set_notification

  def set_notification
    request.env['exception_notifier.exception_data'] = { 'server' => request.env['SERVER_NAME'] }
    # can be any key-value pairs
  end

  def render_500(e)
    ExceptionNotifier.notify_exception(e, :env => request.env, :data => {:message => "error"})
    render template: 'errors/error_500', status: 500
  end
end
