class Controller
  constructor: (@canvas) ->
    @drawing = new Drawing
    @painter = new Painter(@canvas.getContext("2d"))

  setTouchEvents: ->
    @canvas.addEventListener "touchStart", @touchStart, false
    @canvas.addEventListener "touchMove", @touchMove, false
    @canvas.addEventListener "touchEnd", @touchEnd, false

  touchStart: (touchEvent) =>
    @touchStarted = true
    drawInfo = @drawing.startDrawing touchEvent.x, touchEvent.y
    @painter.startDraw(drawInfo)

  touchMove: (touchEvent) =>
    drawInfo = @drawing.add(touchEvent.x, touchEvent.y)
    @painter.drawing(touchEvent)

  touchEnd: (touchEvent) =>
    @drawing.endDrawing
    @painter.endDraw
class Painter
  constructor: (@context) ->

  draw: (size, color, pointArray) ->
    pointX, pointY
    @context.beginPath()

    for point in pointArray
      @context.moveTo(pointX, pointY)
      @context.lineTo(point.x, point.y)
      pointX = point.x
      pointY = point.y
