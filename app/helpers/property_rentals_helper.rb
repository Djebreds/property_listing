module PropertyRentalsHelper
  def rental_type_name(rental_type)
    translated = []
    translated << t('property.year')
    translated << t('property.month')
    translated << t('property.day')

    rental_names(rental_type, translated)
  end

  def rental_costs_name(rental_type)
    translated = []
    translated << t('property.monthly_costs_for_yearly')
    translated << t('property.monthly_costs')
    translated << t('property.daily_costs')

    rental_names(rental_type, translated)
  end

  private

  def rental_names(rental_name, translate = [])
    case rental_name
    when 'yearly' then translate[0]
    when 'monthly' then translate[1]
    when 'dailys' then translate[2]
    when 'tahunan' then translate[0]
    when 'bulanan' then translate[1]
    when 'harian' then translate[2]
    end
  end
end
