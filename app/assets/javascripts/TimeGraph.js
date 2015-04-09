function TimeGraph(margin, width, height, selector) {
  this.margin = margin;
  this.width = width - margin.left - margin.right;
  this.height = height - margin.top - margin.bottom;
  this.parseDate = d3.time.format('%Y-%m-%dT%H:%M:%S.%LZ').parse;
  this.x = d3.time.scale().range([0, this.width]);
  this.y = d3.scale.linear().range([this.height, 0]);
  this.color = d3.scale.category10();
  this.xAxis = d3.svg.axis().scale(this.x).orient('bottom');
  this.yAxis = d3.svg.axis().scale(this.y).orient('left');
  this.line = d3.svg.line().interpolate('basis')
    .x(function (d) { return x(d.time); })
    .y(function (d) { return y(d.value); });
  this.svg = d3.select(selector).append('svg')
    .attr('width', width).attr('height', height).append('g')
    .attr('transform', 'translate(' + margin.left + ',' + margin.top + ')');
}
TimeGraph.prototype.setDomain = function (data) {
  var times = [];
  data.forEach(function (d) {
    d.data.forEach(function (d) {
      d.time = parseDate(d.created_at);
      times.push(d.time);
    });
  });
  this.x.domain(d3.extent(times, function (d) { return d; }));
  this.y.domain([
    d3.min(data, function (d) {
      return d3.min(d.data, function (d) { return d.value; });
    }),
    d3.max(data, function (d) {
      return d3.max(d.data, function (d) { return d.value; });
    })
  ]);
};
TimeGraph.prototype.loadGraph = function (data) {
  var names = data.map(function (d) {
    return d.name;
  }).push("average");
  this.color.domain(d3.keys(names));
  setDomain(data);
  this.svg.append("g").attr("class", "x axis")
    .attr("transform", "translate(0," + (this.height + 10) + ")")
    .call(this.xAxis);
  this.svg.append("g").attr("class", "y axis")
    .attr("transform", "translate(-10, 0)")
    .call(this.yAxis);
  var nodes = [];
  data.forEach(function (v, i) {
    if(i != 0 || average === undefined) {
      var c = this.color(v.name);
      svg.append("path")
        .attr("d", this.line(v.data))
        .attr("stroke", c)
        .attr("stroke-width", 1)
        .attr("fill", "none");
      v.data.forEach(function (d) {
        nodes.push({
          name: v.name,
          color: c,
          data: d
        });
      });
    }
  });
  var node = svg.selectAll(".node")
    .data(nodes)
    .enter()
    .append("a")
    .attr("class", "node")
    .attr("transform", function (d) {
      return "translate(" + this.x(d.data.time) + "," + this.y(d.data.value) + ")";
    });
  var circle = node.append("circle")
    .attr("stroke", "black")
    .attr("fill", function (d) { return d.color; })
    .attr("r", 3.75);
  $('svg .node').tipsy({
    gravity: $.fn.tipsy.autoNS,
    html: true,
    title: function () {
      var d = this.__data__;
      var date = new Date(d.data.created_at);
      var dataColor = function (c) {
        return '<span style="font-size: 150%; color: ' +
                d.color + ';">' + c + "</span>";
      };
      var string = "<h4>" + dataColor(d.name) + "</h4>" +
                   "Date: " + dataColor(date.toDateString()) +
                   "<br>Time: " + dataColor(date.toTimeString()) +
                   "<br>Value: " + dataColor(d.data.value);
      if(d.data.notes === null) {
        return string;
      } else {
        return string + '<br>Notes:<span style="font-size: 150%; color: ' +
               d.color + ';"> ' + d.data.notes + "</span>";
      }
    }
  })
};
TimeGraph.prototype.reloadGraph = function (data) {
  $(this.selector + ' svg g').empty();
  this.loadGraph(data);
};
