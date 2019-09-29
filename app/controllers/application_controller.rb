class ApplicationController < ActionController::Base
  before_action :set_notification
  before_action :ensure_domain

  FQDN = "www.tadoku.site"

  def set_notification
    request.env['exception_notifier.exception_data'] = { 'server' => request.env['SERVER_NAME'] }
    # can be any key-value pairs
  end

  def render_500(e)
    ExceptionNotifier.notify_exception(e, :env => request.env, :data => {:message => "error"})
    render template: 'errors/error_500', status: 500
  end

  def ensure_domain
    return unless /\.herokuapp.com/ =~ request.host

    port = ":#{request.port}" unless [80, 443].include?(request.port)
    redirect_to "#{request.protocol}#{FQDN}#{port}#{request.path}", status: :moved_permanently
  end
end
