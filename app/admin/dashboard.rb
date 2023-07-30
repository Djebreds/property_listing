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
              div data: {
                    target: 'get-all-property-places.latitude',
                            'get-all-property-places-latitude-value': Property.all.pluck(:latitude).to_json } do
                            end
              div data: {
                    target: 'get-all-property-places.longitude',
                            'get-all-property-places-longitude-value': Property.all.pluck(:longitude).to_json } do
                            end
              div data: {
                    target: 'get-all-property-places.name',
                            'get-all-property-places-name-value': Property.all.pluck(:name).to_json } do
                            end
              div data: {
                    target: 'get-all-property-places.location',
                            'get-all-property-places-location-value': Property.all.pluck(:location).to_json } do
                            end
              div data: {
                    target: 'get-all-property-places.category',
                            'get-all-property-places-category-value': Property.includes(property_category: :translations).where("property_category_translations.locale = ?", I18n.locale).pluck("property_category_translations.name").to_json } do
                            end
              div data: {
                    target: 'get-all-property-places.type',
                            'get-all-property-places-type-value': Property.includes(property_type: :translations).where("property_type_translations.locale = ?", I18n.locale).pluck('property_type_translations.name').to_json } do
                            end
              div data: {
                    target: 'get-all-property-places.kindName',
                            'get-all-property-places-kind-name-value':  Property.includes(property_kinds: :translations).where("property_kind_translations.locale = ?", I18n.locale).pluck("property_kind_translations.kind").to_json } do
                            end
              div data: {
                    target: 'get-all-property-places.rentalName',
                            'get-all-property-places-rental-name-value': Property.includes(property_rentals: :translations).where("property_rental_translations.locale = ?", I18n.locale).pluck('property_rental_translations.rental_type').to_json } do
                            end
              div data: {
                  target: 'get-all-property-places.rprice',
                          'get-all-property-places-rprice-value': Property.includes(:property_rentals).pluck('property_rentals.price_cents').map { |price| Money.from_cents(price, 'IDR').format }.to_json } do
                          end
              div data: {
                  target: 'get-all-property-places.kprice',
                          'get-all-property-places-kprice-value': Property.includes(:property_kinds).pluck('property_kinds.price_cents').map { |price| Money.from_cents(price, 'IDR').format }.to_json } do
                          end
          end
        end
      end
    end
  end
end
