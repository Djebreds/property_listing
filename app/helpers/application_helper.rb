module ApplicationHelper
  def available_currencies
    { 'IDR' => 'IDR', 'USD' => 'USD', 'AUD' => 'AUD', 'GBP' => 'GBP' }
  end

  def default_meta_tags
    {
      site: ENV['DEVELOPMENT_HOSTS'],
      title: 'PropertyListing',
      reverse: true,
      separator: '|',
      description: t('header.meta_description_tags'),
      keywords: 'property, list, rental, house, land, villa, freehold, leasehold, rental monthly, rental daily, rental yearly',
      canonical: request.original_url,
      noindex: !Rails.env.production?,
      icon: [
        { href: image_url('favicon.ico') },
      ],
      og: {
        site_name: ENV['DEVELOPMENT_HOSTS'],
        title: 'PropertyListing',
        description: t('header.meta_description_tags'),
        type: 'website',
        url: request.original_url,
      }
    }
  end
end
