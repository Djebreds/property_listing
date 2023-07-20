module PropertyFacilityHelper
  def property_furnished(property_facility)
    case property_facility
    when 'furnished' then t('property.furnished')
    when 'not_furnished' then t('property.not_furnished')
    end
  end

  def property_water_resource(property_facility)
    case property_facility
    when 'drilled_wells' then t('property.drilled_wells')
    when 'pdam' then t('property.pdam')
    end
  end

  def property_internet(property_facility)
    case property_facility
    when 'wireless' then t('property.wireless')
    when 'fiber_optic' then t('property.fiber_optic')
    end
  end

  def property_parking(property_facility)
    case property_facility
    when 'closed' then t('property.closed')
    when 'opened' then t('property.opened')
    end
  end
end
