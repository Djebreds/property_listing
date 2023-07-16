$(document).on('change', '#place-search', function () {
  var query = $(this).val();

  $.ajax({
    url: '/google_map_places',
    method: 'GET',
    dataType: 'json',
    data: { q: query },
    success: function(response) {
      var PropertyLocationID = $('#property_property_location_id');
      PropertyLocationID.empty();

      $.each(response, function(index, propertyLocation) {
        PropertyLocationID.append($('<option>').text(propertyLocation.name).attr('value', propertyLocation.name))
      })
    }
  })
})
