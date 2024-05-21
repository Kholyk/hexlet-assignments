# frozen_string_literal: true

class SetLocaleMiddleware
  def initialize(app)
    @app = app
  end

  # BEGIN
  def call(env)
    dup._call(env)
  end

  def _call(env)
    request = Rack::Request.new(env)

    set_user_locale(request)

    @app.call(env)
  end

  private

  def set_user_locale(request)
    default_locale = I18n.locale
    return default_locale if request.env['HTTP_ACCEPT_LANGUAGE'].nil?

    user_locale = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    return default_locale unless I18n.available_locales.include?(user_locale.to_sym)

    I18n.locale = user_locale.to_sym
  end
  # END
end
