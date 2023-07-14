$(document).on('change', '#property_property_category_id', function() {
  var categoryId = $(this).val();
  var url = '/property_categories/' + categoryId + '/property_types';

  $.ajax({
    url: url,
    method: 'GET',
    dataType: 'json',
    success: function(response) {
      var propertyTypeSelect = $('#property_property_type_id');
      propertyTypeSelect.empty();

      $.each(response, function(index, propertyType) {
        propertyTypeSelect.append($('<option>').text(propertyType.name).attr('value', propertyType.id));
      });
    }
  });
});
