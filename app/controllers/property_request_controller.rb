class PropertyRequestController < ApplicationController
  def new_request
    @property_request = PropertyRequest.new
  end

  def send_request
    @property_request = PropertyRequest.new(property_request_params)

    return if check_recaptcha

    if verify_recaptcha(model: @property_request)  && @property_request.save
      respond_to do |format|
        flash[:notice] = t('property_request.request_success')
        format.html { redirect_to root_path }
      end
    else
      render :new_request, status: :unprocessable_entity
    end
  end

  private

  def check_recaptcha
    if params[:'g-recaptcha-response'].blank?
      flash[:error] = t('property_request.recaptcha_fails')
      redirect_to property_request_new_request_path
    end
  end

  def property_request_params
    params.require(:property_request)
          .permit(:first_name, :last_name, :email, :description, :phone,
                  :'g-recaptcha-response', property_type: [], property_category: [])
  end
end
