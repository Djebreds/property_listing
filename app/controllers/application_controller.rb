class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :set_locale, :set_currency
  after_action :verify_authorized, except: %i[index about contact set_currency detail send_request new_request search], unless: -> { bypass_pundit? }

  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    I18n.locale = I18n.available_locales.include?(locale) ? locale : I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def set_currency
    @currency = session[:currency] || 'IDR'
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  private

  def bypass_pundit?
    is_a?(ActiveAdmin::BaseController) || devise_controller?
  end
end
