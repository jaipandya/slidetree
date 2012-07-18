var width = 960,
    height = 500,
    color = d3.scale.category20c();

var treemap = d3.layout.treemap()
    .size([width, height])
    .sticky(false)
    .value(function(d) { return d.size; });

var div = d3.select("#chart").append("div")
    .style("position", "relative")
    .style("width", width + "px")
    .style("height", height + "px");

d3.json("/get_popular", function(json) {
  div.data([json]).selectAll("div")
      .data(treemap.nodes)
    .enter().append("div")
      .attr("class", "cell")
      .style("background", function(d) { return d.children ? 'none' : 'url(' + d.thumbnail_url  + ')' + 'no-repeat'; })
      .style("border", 'black 1px solid')
      .call(cell)
      .text(function(d) { return d.children ? null : d.value; });
});

function cell() {
  this
      .style("left", function(d) { return d.x + "px"; })
      .style("top", function(d) { return d.y + "px"; })
      .style("width", function(d) { return Math.max(0, d.dx - 1) + "px"; })
      .style("height", function(d) { return Math.max(0, d.dy - 1) + "px"; });
}
