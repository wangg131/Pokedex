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
    var url = "http://pokeapi.co/api/v1/pokemon/" + search_input;

    $.ajax(url, {
      type: 'GET',
      success: pokemonStats
    });

  });

  function displayData(data) {
    for (var i = 0; i < data.length; i++) {
      pokemon_name = data[i].artist + ": " + data[i].title;
      url = data[i].url;
      var anchor = $('<a></a>');
      anchor.text(artist_title);
      anchor.prop('href', url);
      var p_tag = $('<p></p>');
      p_tag.append(anchor);
      $('.results').append(p_tag);
    }
    return data;
  }

  function pokemonStats(data) {
    var pokedex = $( ".results" ).addClass( "pokedex" );
    var $sprite = $( "<div class='sprite'/>" );
    var $description = $("<div class='description'/>");
    pokedex.append($sprite, $description);


  }

});
