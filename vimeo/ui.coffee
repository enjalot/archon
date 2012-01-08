iframew = 540
iframeh = 300

svgw = 540
svgh = iframeh - 50


iframe = d3.select("#player1")
    .attr("width", iframew)
    .attr("height", iframeh)

svg = d3.select("#overlay")
    .attr("width", svgw)
    .attr("height", svgh)

svg.append("svg:rect")
    .attr("width", "100%")
    .attr("height", "100%")
    .attr("fill", "#00f")
    .attr("fill-opacity", .3)


starts =    [0, 1, 5]
durs =      [0, 3, 4]

cxs = [100, 200, 50]
cys = [100, 200, 150]
rs = [25, 50, 100]

colors = d3.scale.linear()
    .domain([0, starts.length])
    .interpolate(d3.interpolateRgb)
    .range(["#ff0000", "#0000ff"])

tocks = new enja.Tocks()
_.each(starts, (s, i) ->
    svg.append("svg:circle")
        .attr("id", "circle" + i)
        .attr("cx", cxs[0])
        .attr("cy", cys[0])
        .attr("r", rs[0])
        .attr("fill", "#bbbb00")
        .attr("fill-opacity", .5)


    tock = (evtype, data) ->
        if evtype is "start"
            d3.select("#circle"+i)
                .transition()
                .duration(durs[i] * 1000)
                .attr("cx", cxs[i])
                .attr("cy", cys[i])
                .attr("r", rs[i])
                .attr("fill", colors[i])

        if evtype is "end"
            d3.select("#circle0")
                #.attr("cx", 100)
                #.attr("cy", 100)
                #
        if evtype is "seek"
            d3.select("#circle"+i)
                .attr("cx", cxs[0])
                .attr("cy", cys[0])
                .attr("r", rs[0])
                .attr("fill", "#bbbb00")
         

    tocks.add({start:s, end: s+durs[i], callback:tock})
)




