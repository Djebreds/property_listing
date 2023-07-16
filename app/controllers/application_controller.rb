class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :set_locale
  after_action :verify_authorized, except: :index, unless: -> { bypass_pundit? }

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options={})
    { :locale => I18n.locale }
  end

  private

  def bypass_pundit?
    is_a?(ActiveAdmin::BaseController) || devise_controller?
  end
end
