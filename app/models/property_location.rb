class PropertyLocation < ApplicationRecord
  reverse_geocoded_by :latitude, :longitude

  belongs_to :property
end
