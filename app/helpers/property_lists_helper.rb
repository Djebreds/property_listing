module PropertyListsHelper
  def property_enclosed_type(property_indoor)
    case property_indoor
    when 'enclosed' then t('property.enclosed')
    when 'not_enclosed' then t('property.not_enclosed')
    end
  end

  def property_available(property_indoor)
    case property_indoor
    when 'yes' then t('property.available')
    when 'no' then t('property.not_available')
    end
  end
end
