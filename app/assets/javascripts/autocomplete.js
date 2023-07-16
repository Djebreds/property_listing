$(document).ready(function() {
  var input = document.getElementById('location_address');
  var autocomplete = new google.maps.places.Autocomplete(input);

  google.maps.event.addListener(autocomplete, 'place_changed', function() {
    var place = autocomplete.getPlace();
    $('#location_latitude').val(place.geometry.location.lat());
    $('#location_longitude').val(place.geometry.location.lng());
  });
});
