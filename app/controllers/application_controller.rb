class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :set_locale
  after_action :verify_authorized, except: %i[index about contact], unless: -> { bypass_pundit? }

  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    I18n.locale = I18n.available_locales.include?(locale) ? locale : I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end

  private

  def bypass_pundit?
    is_a?(ActiveAdmin::BaseController) || devise_controller?
  end
end
