class PropertyRequestController < ApplicationController
  def send_request
    @property_request = PropertyRequest.new(property_request_params)

    if verify_recaptcha(model: @property_request) && @property_request.save!
      flash[:notice] = t('property.request_success')
      redirect_to root_path
    else
      flash[:error] = t('property.request_failed')
      redirect_to root_path
    end
  end

  private

  def property_request_params
    params.require(:property_request).permit(
                    :first_name, :last_name, :email, :description,
                    :phone, property_type: [], property_category: [])
  end
end
