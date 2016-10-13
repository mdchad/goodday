//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/
$('#counter').html('<%= escape_javascript(page_entries_info(@favorites, :remote => true).to_s) %>');


$(document).on('turbolinks:load', function () {
  $('.like').on('ajax:success', function (e, data) {
    $("#upvotes-" + data.goal).empty().append(data.votesup);
    $("#downvotes-" + data.goal).empty().append(data.votesdown);

  })
  $('.dislike').on('ajax:success', function (e, data) {
    $("#upvotes-" + data.goal).empty().append(data.votesup);
    $("#downvotes-" + data.goal).empty().append(data.votesdown);
  })
})
