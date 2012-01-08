svg_head = """
<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.0//EN" "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd">
<svg version="1.0" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
<g id="demoholder">
"""

svg_foot = """
</g>
</svg>
"""


svgeditor = ace.edit("js_div0")
dataeditor = ace.edit("js_div1")
codeeditor = ace.edit("js_div2")


init = () ->
    console.log "sup"
    JavascriptMode = require("ace/mode/javascript").Mode
    console.log "svgeditor", svgeditor

    #video view
    
    #code views
    svgeditor.setTheme("ace/theme/twilight")
    svgeditor.getSession().setMode(new JavascriptMode())
    svgeditor.getSession().setValue(svg_code)

    dataeditor.setTheme("ace/theme/twilight")
    dataeditor.getSession().setMode(new JavascriptMode())
    dataeditor.getSession().setValue(data_code)

    codeeditor.setTheme("ace/theme/twilight")
    codeeditor.getSession().setMode(new JavascriptMode())
    codeeditor.getSession().setValue(demo_code)

    #svginsert()


    #demo view

    $('#js_div0').show()
    $('#js_div1').show()
    $('#js_div2').show()

    d3.select('#update').on("click", () ->
        #svginsert()
        #dataeval()
        #codeeval()

        #empty the current demo
        d3.select("#demo").remove()
        d3.select("#demosvg").append("svg:g")
            .attr("id","demo")

        update()
    )

update = () ->
#svginsert = () =>
    #the svg box should only define svg elements, not an actualy <svg> tag, we add that for them
    svg = svg_head + svgeditor.getSession().getValue() + svg_foot
    #console.log "svg", svg
    #had to dig into d3 internals to get this part
    range = document.createRange()
    range.selectNode(document.body)
    node = range.createContextualFragment(svg)

    svgnode = d3.select(node)
    #console.log "svgnode", svgnode.select("#demoholder").node()
    demosvg = document.importNode(svgnode.select("#demoholder").node(), true)
   
    #console.log "NODE", node
    #console.log "demosvg", demosvg
    
    d3.select("#demo").node().appendChild(demosvg)
    

#dataeval = () =>
    data = dataeditor.getSession().getValue()
    #console.log "data"#, data
    eval(data)

#codeeval = () =>
    code = codeeditor.getSession().getValue()
    #console.log "code"#, code
    eval(code)
    #console.log("options", options)


    console.log "THE DEMO NODE"
    #console.log String(d3.select("#demo").node())
    console.log d3.select("#demo").node()

    #Put the svg of the demo back in the editor
    html = $('<div>').append($('#demoholder').clone()).remove().html()
    #console.log "HTML", html
    inner = html.slice(19, -4)

    #svgeditor.getSession().setValue(inner)



   

