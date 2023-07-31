class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :set_locale, :set_currency
  after_action :verify_authorized, except: %i[index about contact set_currency detail send_request search], unless: -> { bypass_pundit? }

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
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
