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
      name_and_id = data.name + " #" + data.id;
      var type1 = data.type1;
      var type2 = data.type2;
      description = data.description;
      evolutions = data.level + data.method + data.to;
      var sprite = "http://pokeapi.co" + data.sprite;
      var img = new Image();
      img.src = sprite;
      $('.description').append(name_and_id, type1, type2, description, evolutions);
      $('.sprite').append(img);
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
