// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

$(function() {

  $(".search").click(function(event) {
    event.preventDefault();

// TODO rename classes of the divs appropriately
    var searchButton = $(this);
    var formTag = searchButton.parents(".form");
    var text_box = formTag.children(".text_box");
    var search_input = text_box.val();
    var url = "http://pokeapi.co/api/v1/pokemon/";

    $.ajax(url, {
      type: 'GET',
      success: pokemonStats
    });

  });

  function pokemonStats(data) {


  }

});
