# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t('active_admin.dashboard') } do
    columns do
      column do
        panel t('active_admin.visitor_based_on_property') do
          column_chart Property.joins(:visitors).group(:name).distinct.count(:ip_address)
        end
      end

      column do
        panel t('active_admin.all_property_location') do
          div id: 'map', data: {
            controller: 'get-all-property-places',
            action: "google-maps-callback@window->get-all-property-places#initMap",
            target: 'get-all-property-places.map'
          }, style: 'width: 100%; height: 400px;' do
            div data: { target: 'get-all-property-places.latitude', 'get-all-property-places-latitude-value': Property.all.pluck(:latitude).to_json }
            div data: { target: 'get-all-property-places.longitude', 'get-all-property-places-longitude-value': Property.all.pluck(:longitude).to_json }
            div data: { target: 'get-all-property-places.name', 'get-all-property-places-name-value': Property.all.pluck(:name).to_json }
            div data: { target: 'get-all-property-places.location', 'get-all-property-places-location-value': Property.all.pluck(:location).to_json }
            div data: { target: 'get-all-property-places.category', 'get-all-property-places-category-value': Property.includes(:property_category).pluck('property_categories.name').to_json }
            div data: { target: 'get-all-property-places.type', 'get-all-property-places-type-value': Property.includes(:property_type).pluck('property_types.name').to_json }
            div data: { target: 'get-all-property-places.kindName', 'get-all-property-places-kind-name-value': Property.includes(:property_kinds).pluck('property_kinds.kind').join(', ').capitalize.to_json }
            div data: { target: 'get-all-property-places.rentalName', 'get-all-property-places-rental-name-value': Property.includes(:property_rentals).pluck('property_rentals.rental_type').join(', ').capitalize.to_json }
            div data: {
                target: 'get-all-property-places.rprice',
                        'get-all-property-places-rprice-value': Property.includes(:property_rentals).pluck('property_rentals.price_cents').map { |price| Money.from_cents(price, 'IDR').format }.to_json }
            div data: {
                target: 'get-all-property-places.kprice',
                        'get-all-property-places-kprice-value': Property.includes(:property_kinds).pluck('property_kinds.price_cents').map { |price| Money.from_cents(price, 'IDR').format }.to_json }
          end
        end
      end
    end
  end
end
