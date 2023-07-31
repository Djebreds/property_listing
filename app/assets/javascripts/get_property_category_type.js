  $(document).ready(function() {
    // Function to update the property types based on the selected category
    function updatePropertyTypes() {
      let property_category_id = $('#q_property_category_id').val();
      $.ajax({
        url: 'property/property_type',
        data: { property_category_id: property_category_id },
        dataType: 'json',
        success: function(response) {
          // Find the property type filter's select element
          let propertyTypeSelect = $('#type');
          console.log(propertyTypeSelect)
          propertyTypeSelect.find('option').remove();

          propertyTypeSelect.append($('<option>').text('All').attr('value', ''));

          $.each(response, function(index, option) {
            let newOption = new Option(option.name, option.id);
            propertyTypeSelect.append(newOption);
          });

          propertyTypeSelect.select2('destroy').select2();
        },
        error: function() {
          console.log('Error fetching property types.');
        }
      });
    }

  // Trigger the update when the category select changes
  $('#q_property_category_id').on('change', function() {
    updatePropertyTypes();
  });

  // Trigger the update on page load
  updatePropertyTypes();
});
