class LocaleController < ApplicationController
  def set
    request_locale = params[:switch_locale] || params[:locale]

    if locale_is_available?(request_locale)
      I18n.locale = request_locale
      session[set_user_language_locale_key] = requested_locale
      flash[:notice] = 'Language changed successfully'
    else
      flash[:error] = 'Language failed to change'
    end

    redirect_back(fallback_location: root_path)
  end

  private

  def locale_is_available?(locale)
    locale
  end
end
