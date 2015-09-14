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
      var name_and_id = "<h2>"+ data.name + " #" + data.id +"</h2>";
      var sprite = "http://pokeapi.co" + data.sprite;
      var img = new Image();
      img.src = sprite;
      $('.sprite').append(img);
      var two_types = "<p>Types: " + data.type1 + " & " + data.type2 + "</p>";
      var one_type = "<p>Type: " + data.type1 + "</p>";
      if (data.hasOwnProperty('type2')) {
        $('.description').append(name_and_id, two_types, data.description);
      }
      else {
        $('.description').append(name_and_id, one_type, data.description);
      }
    return data;
  }

  function pokemonStats(data) {
    var pokedex = $( ".results" ).addClass( "pokedex" );
    var $sprite = $( "<div class='sprite'/>" );
    var $description = $("<div class='description'/>");
    if ($('.results').is(':empty')) {
        pokedex.append($sprite, $description);
    } else {
      pokedex.empty().append($sprite, $description);
    }
    displayData(data);
  }
});
