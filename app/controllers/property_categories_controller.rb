class PropertyCategoriesController < ApplicationController
  def index
    respond_to do |format|
      format.json { render json: PropertyCategory.all }
    end
  end
end
