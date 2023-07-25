# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t('active_admin.dashboard') } do
    columns do
      column do
        panel 'Visitor Based on Property' do
          column_chart Property.joins(:visitors).group(:name).distinct.count(:ip_address)
        end
      end

      column do
        panel 'All Property location' do
          div id: 'map', data: {
            controller: 'get-all-property-places',
            action: "google-maps-callback@window->get-all-property-places#initMap",
            target: 'get-all-property-places.map'
          }, style: 'width: 100%; height: 400px;' do
            div data: { target: 'get-all-property-places.latitude', 'get-all-property-places-latitude-value': Property.all.pluck(:latitude).to_json }
            div data: { target: 'get-all-property-places.longitude', 'get-all-property-places-longitude-value': Property.all.pluck(:longitude).to_json }
          end
        end
      end
    end
  end
end
