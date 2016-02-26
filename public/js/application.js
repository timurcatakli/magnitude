$(document).ready(function () {



  $('#us3').locationpicker({
      location: {latitude: 46.15242437752303, longitude: 2.7470703125},
      radius: 300,
      inputBinding: {
          latitudeInput: $('#us3-lat'),
          longitudeInput: $('#us3-lon'),
          radiusInput: $('#us3-radius'),
          locationNameInput: $('#us3-address')
      },
      enableAutocomplete: true,
      onchanged: function (currentLocation, radius, isMarkerDropped) {
          alert("Location changed. New location (" + currentLocation.latitude + ", " + currentLocation.longitude + ")");
      }
  });


    // Intercept Write Post Form Submit
  $('#user_new_card').on('submit', '#user_new_form', function(e){
    e.preventDefault();
    
    var $data = $(this).serialize();
    console.log($data);


    // ajax request starts
      $.ajax({
        method: "post",
        url: "/user/new",
        data: $data
      })
      .done(function(data) {
        console.log(data);
      })

      .fail(function() {
        console.log("fail")
      })
    // ajax request ends



  });
  // Intercept Write Post Form Submit



});
