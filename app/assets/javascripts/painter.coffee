class @Painter
  constructor: (@el) ->
   @context = @el.getContext "2d"
   @canvas = $(@el)
   @canvasWidth = @canvas.width()
   @canvasHeight = @canvas.height()
   @painting = false
  
   @context.strokeStyle = "black"
   @context.lineWidth = 5
   @context.lineJoin = "round"
   @context.lineCap = "round"

  startDrawing: (stroke) ->
    @context.strokeStyle = stroke.color
    @context.lineWidth = stroke.size
    @context.beginPath()
    @context.moveTo stroke.x, stroke.y

    @painting = true

  drawing: (point) ->
    if @painting
      @context.lineTo point.x, point.y
      @context.stroke()

  endDrawing: ->
    @painting = false if @painting

  drawNewPicture: (frames) ->
    @context.clearRect 0, 0, @canvasWidth, @canvasHeight
    @isDrawing = false
    @drawPicture frames

  drawPicture: (frames) ->
    return null if frames.length <= 0

    for frame in frames
      @drawFrame frame

    @context.stroke() if @isDrawing

  drawFrame: (frame) ->
    switch frame.type
      when "stroke"
        if @isDrawing
          @context.stroke()
          @isDrawing = false
        
        @context.strokeStyle = frame.color
        @context.strokeWidth = frame.size
        @context.beginPath()
      when "point"
        unless @isDrawing
          @context.moveTo frame.x, frame.y
          @isDrawing = true
        else
          @context.lineTo frame.x, frame.y
