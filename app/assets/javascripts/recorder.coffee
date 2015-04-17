class Stroke
  constructor: (@startedAt, @color, @size) ->
    @frames = []
    @framePointer = 0

  addFrame: (x, y) ->
    @frames.add
      time: Date.now() - @startedAt
      x: x
      y: y

  nextFrame: ->
    @framePointer++
    if @frames.length <= @framePointer
      return null
    else
      return @frames[@framePointer]


class Recorder
  constructor: ->
    @strokes = []
    @strokesPointer = 0

  startRecording: ->
    @strokes = [] if @strokes
    @strokesPointer = 0

  addStroke: (stroke) ->
    @strokes.add stroke

  nextStroke: ->
    @strokesPointer++
    if @strokes.length <= @strokesPointer
      return null
    else
      return @strokes[@strokesPointer]

  rewind: ->
    @strokesPointer = 0

class Player
  constructor: (@el, @recorder) ->

  play: ->
    @recorder.rewind()
    @nextRecord

  nextRecord: =>
    if stroke = @recorder.nextStroke()
      @context.lineJoin = "round"
      @context.lineCap = "round"
      @context.strokestyle = stroke.color
      @context.lineWidth = parseFloat(stroke.size)
      @context.beginPath()

      frame = stroke.nextFrame()
      startedAt = stroke.startedAt
      context = @context

      timer = setInterval ->
        elapsedTime = Date.now() - startedAt
        while frame? and frame.time < elapsedTime
          context.lineTo frame.x, frame.y 
          frame = stroke.nextFrame()
        context.stroke()

        if frame == null
          clearInterval timer
          @nextRecord
      , 17