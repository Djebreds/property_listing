module PropertyKindsHelper
  def kind_costs_name(kind)
    translated = []
    translated << t('property.freehold_costs')
    translated << t('property.leasehold_costs')

    kind_names(kind, translated)
  end

  def kind_names(kind_name, translate = [])
    case kind_name
    when 'freehold' then translate[0]
    when 'leasehold' then translate[1]
    when 'hak milik' then translate[0]
    when 'penyewaan' then translate[1]
    end
  end
end
