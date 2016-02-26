$(document).ready(function () {

  // Location Picker Code Starts Here
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
  // Location Picker Code Starts Here

  // Intercept User Registration Post Form Submit
  $('#user_new_card').on('submit', '#user_new_form', function(e){
    e.preventDefault();

    $( ".div_registration" ).slideUp( "slow", function() {
      // Animation complete.
      $('.div_sms').show()
    });

    
    var $data = $(this).serialize();
    console.log($data);


    // ajax request starts
      $.ajax({
        method: "post",
        url: "/users/new",
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
  // Intercept User Registration Post Form Submit

  // Intercept User Login Link
  $('#form_sms').on('click', 'a.btn_sms', function(e){
    e.preventDefault();
    $('.alert-success').hide();
    $('.alert-danger').hide();
    var $data = $(this).parent().parent().parent().serialize();
    console.log($data)
    // ajax request starts
      $.ajax({
        method: "post",
        url: "/users/verification",
        data: $data
      })
      .done(function(data) {
        if (data.match == true) {
          $('.alert-success').show();
        } else {
          $('.alert-danger').show();
        }

      })

      .fail(function() {
        console.log("fail")
      })
    // ajax request ends



  });
  // Intercept User Login Link




});
