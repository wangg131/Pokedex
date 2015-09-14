// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

$(function() {

  $(".search").click(function(event) {
    event.preventDefault();

    var searchButton = $(this);
    var formTag = searchButton.parents(".navbar-form");
    var text_box = formTag.children(".text_box");
    var search_input = text_box.val();
    var url = "/" + search_input;

    $.ajax(url, {
      type: 'GET',
      success: pokemonStats
    });
  });

  function displayData(data) {
    console.log(data);
      name = data.name + data.id;
      id = data.id;
      type = data.type;
      description = data.description;
      evolutions = data.evolutions;
      $('.description').append(name, type, description);
    return data;
  }

  function pokemonStats(data) {
    var pokedex = $( ".results" ).addClass( "pokedex" );
    var $sprite = $( "<div class='sprite'/>" );

    var $description = $("<div class='description'/>");
    pokedex.append($sprite, $description);
    displayData(data);
  }
});
