class @Canvas
  constructor: (args) ->
    @el = args['canvasElement']
    @canvas = $(@el)
    @observers = []
    @bindEvents()
    @drawing = false
    @color = "black"
    @size = 5

  bindEvents: ->
    canvasEvents = [
      "click",
      "mousedown",
      "mouseup",
      "mousemove",
      "mouseleave",
      "mouseout",
      "touchstart",
      "touchmove",
      "touchend",
      "touchcancel"
    ]

    @canvas.bind canvasEvents.join(" "), (e) =>
      e.preventDefault()
      if e.originalEvent && e.originalEvent.changedTouches
        e.pageX = e.originalEvent.changedTouches[0].pageX
        e.pageY = e.originalEvent.changedTouches[0].pageY

      data =
       x: e.pageX - @canvas.offset().left
       y: e.pageY - @canvas.offset().top

      switch e.type
        when "mousedown", "touchstart"
          @drawing = true
          for observer in @observers
            observer.startDrawing
              color: @color
              size: @size
              x: data.x
              y: data.y
        when "mousemove", "touchmove"
          if @drawing
            for observer in @observers
              observer.drawing
                x: data.x
                y: data.y
        when "mouseup", "mouseleave", "mouseout", "touchend", "touchcancel"
          if @drawing
            for observer in @observers
              observer.endDrawing()
            @drawing = false


  addObserver: (observer) ->
    @observers.push observer

  addObservers: (observers) ->
    @observers = @observers.concat observers

  set: (key, value)->
      this[key] = value
      @canvas.trigger("sketch.change#{key}", value)
