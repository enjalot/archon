
svg_code = """
<g id="barchart" transform="translate(120, 10)"></g>

<g id="buttons">
    <g id="data1" transform="translate(10, 15)">
    <rect width='100' height='30' fill="#ccc"></rect>
    <text dy='1.25em' text-anchor="middle" transform="translate(50,0)">Data 1</text>
    </g>

    <g id="data2" transform="translate(10, 55)">
    <rect width='100' height='30' fill="#ccc"></rect>
    <text dy='1.25em' text-anchor="middle" transform="translate(50,0)">Data 2</text>
    </g>

    <g id="random" transform="translate(10, 95)">
    <rect width='100' height='30' fill="#ccc"></rect>
    <text dy='1.25em' text-anchor="middle" transform="translate(50,0)">Random</text>
    </g>
</g>

"""

data_code = """
var data1 = [ 5,20,55,60,89 ]

var data2 = [ 35,80,35,90,19,39,99 ]

function random(n)
{
    val = []
    for(i = 0; i < n; i++)
    {
        val.push(Math.random() * 100)
    }
    return val
}
"""

demo_code = """
var w = 300
var h = 200
function bars(data)
{
    max = d3.max(data)
    x = d3.scale.linear()
        .domain([0, max])
        .range([0, w])

    y = d3.scale.ordinal()
        .domain(d3.range(data.length))
        .rangeBands([0, h], .2)

    var vis = d3.select("#barchart")
    var bars = vis.selectAll("rect.bar")
        .data(data)

    //update
    bars
        .attr("fill", "#0a0")
        .attr("stroke", "#050")

    //enter
    bars.enter()
        .append("svg:rect")
        .attr("class", "bar")
        .attr("fill", "#800")
        .attr("stroke", "#800")

    //exit 
    bars.exit()
        .remove()

    //apply to everything (enter and update)
    bars
        .attr("stroke-width", 4)
        .attr("width", x)
        .attr("height", y.rangeBand())
        .attr("transform", function(d,i) {
            return "translate(" + [0, y(i)] + ")"
        })
}


function init()
{

    //setup our ui
    d3.select("#data1")
        .on("click", function(d,i) {
            bars(data1)
        })   
    d3.select("#data2")
        .on("click", function(d,i) {
            bars(data2)
        })   
    d3.select("#random")
        .on("click", function(d,i) {
            bars(random(7))
        })   

    //make the bars
    bars(data1)
}
init();
"""
