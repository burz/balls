function graph_ready () {
  var margin = { top: 10, bottom: 40, left: 65, right: 20 };
  var width = $('#graphs_container').width();
  var height = 400;
  var league_ratings_graph = new TimeGraph(margin, width, height, '#league_graph_canvas');
  league_ratings_graph.loadGraph(league_ratings_data);
  var season_ratings_graph = new TimeGraph(margin, width, height, '#season_graph_canvas');
  season_ratings_graph.loadGraph(season_ratings_data);
  $('#league_ratings_graph').hide();
}
$(document).ready(graph_ready);
$(document).on('page:load', graph_ready);
