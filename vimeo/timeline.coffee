enja = {}
#class enja.Timeline extends Backbone.Events
#enja.timeline = new enja.Timeline()
enja.timeline = _.extend({}, Backbone.Events)

class enja.Tock extends Backbone.Model
    defaults:
        start: 0
        end: 1
        #callback: undefined

    initialize: ->
        @last_seconds = 0
        enja.timeline.bind("play:progress", @on_play)
        enja.timeline.bind("seek", @on_seek)

    on_seek: (data) =>
        #reset the event if we seek before the event
        @seeked = true
        @last_seconds = data.seconds
        @get("callback")("seek", data)

        if data.seconds < @get("start")
            @start_fired = false
            if data.seconds < @get("end")
                @stop_fired = false

       
    on_play: (data) =>
        #we only want to do our callback if we play through the event
        if @fired
            @last_seconds = data.seconds
            return false

        if not @stop_fired and @get("end") < data.seconds
            @get("callback")("end", data)
            @stop_fired = true

        if not @start_fired and @last_seconds < @get("start") and @get("start") < data.seconds
            @get("callback")("start", data)
            @start_fired = true

        @last_seconds = data.seconds

class enja.Tocks extends Backbone.Collection
    model: enja.Tock
