// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require social-share-button
//= require_tree .

$(document).on('turbolinks:load', function() {



  // Get the modal
  var modal = document.getElementById('myModal');
  console.log("a")
  // Get the button that opens the modal
  var btn = document.getElementById("myBtn");

  // Get the <span> element that closes the modal
  var span = document.getElementsByClassName("close")[0];


  $(document).on('click', '#myBtn', function () {
      modal.style.display = "block"
  })
  // When the user clicks the button, open the modal
  // btn.onclick = function() {
  //     modal.style.display = "block";
  // }


  // When the user clicks on <span> (x), close the modal
  span.onclick = function() {
      modal.style.display = "none";
  }

  $( document ).on( "click", ".close", function() {
    $('modal').hide();
  });

  // When the user clicks anywhere outside of the modal, close it
  document.onclick = function(event) {
      if (event.target == modal) {
          modal.style.display = "none";
      }
  }
});
