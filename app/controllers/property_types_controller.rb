class PropertyTypesController < ApplicationController
  def index
    property_category = PropertyCategory.find(params[:property_category_id])

    respond_to do |format|
      format.json { render json: property_category.property_types }
    end
  end
end
