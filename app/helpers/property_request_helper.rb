module PropertyRequestHelper
  def property_types
    case I18n.locale
    when :en then ['villa', 'land', 'other']
    when :id then ['villa', 'tanah', 'lainnya']
    end
  end
end
