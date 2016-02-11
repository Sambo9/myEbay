// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs

// require turbolinks
//= require_tree .

//= require jquery.raty
//= require ratyrate

//= require jquery-ui
//= require autocomplete-rails
//= require jquery-ui/autocomplete
//= require semantic-ui
//= require bootstrap-sprockets

//= require algolia/v3/algoliasearch.min
//= require algolia/typeahead.jquery
//= require hogan

//= require jquery.datetimepicker

//= require jquery.countdown


$( document ).ready(function(){
   $("#countdown").countdown(
      {
         until : new Date($('#ending_time').text())
   });
});


$( document ).ready(function(){
   $('#datetimepicker').datetimepicker({
      format:'d.m.Y H:i',
      inline:true,
      lang:'fr',
      minDate:'0',//yesterday is minimum date(for today use 0 or -1970/01/01)
      maxDate:'+1970/01/09'
   });
});



var client = algoliasearch("HEXW8VQKX5", "e6b143f8d3534f72a621ec5d05eb70c6"); // public credentials

$(document).ready(function() {
   var template = Hogan.compile("<div class='ui message inverted'>{{{_highlightResult.title.value}}}</div>");
   $('input#search_product').typeahead(null, {
      highligh: false,
      source: client.initIndex('Product').ttAdapter(),
      displayKey: 'title',
      templates: {
         suggestion: function(hit) {
            return template.render(hit);
         }
      }
   });
});

$( document ).ready(function(){
   $('.special.cards .image').dimmer({
      on: 'hover'
   });
});
