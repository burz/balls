var league_ratings_graph = null;
var season_ratings_graph = null;
function graphs_ready () {
  var margin = { top: 10, bottom: 80, left: 80, right: 40 };
  var width = $('#graphs_container').width();
  var height = 450;
  league_ratings_graph = new TimeGraph(margin, width, height, '#league_graph_canvas');
  league_ratings_graph.loadGraph(league_ratings_data);
  season_ratings_graph = new TimeGraph(margin, width, height, '#season_graph_canvas');
  season_ratings_graph.loadGraph(season_ratings_data);
  $('#league_ratings_graph').hide();
}
function reload_graphs () {
  league_ratings_graph.reloadGraph(league_ratings_data);
  season_ratings_graph.reloadGraph(season_ratings_data);
}
