# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#$ ->
#  canvasHeight = $(window).height() - $("#title").height() - $("#menu").height()
#  $("canvas#sketchbook").height canvasHeight
class Stroke
  constructor: (@size, @color) ->
    @currentIndex = -1
    @pointLength = 0
    @pointsX = []
    @pointsY = []

  getColor: ->
    @color

  getSize: ->
    @size

  addPoint: (point) ->
    unless point.x? and point.y?
      return null
    else if @pointsX[@currentIndex] is point.x and @pointsY[@currentIndex] is point.y
      return null
    else
      @pointsX.push(point.x)
      @pointsY.push(point.y)
      @pointLength++

  currentPoint: ->
    if @currentIndex >= 0 and @currentIndex < @pointLength
      _getPoint(@currentIndex)
    else
      null

  nextPoint: ->
    if (@currentIndex + 1) >= @pointLength
      null
    else
      _getPoint(@currentIndex + 1)
      
  prevPoint: ->
    if (@currentIndex - 1) < 0
      null
    else
      _getPoint(@currentIndex - 1)
      
  next: ->
    @currentIndex++ if @currentIndex < @pointLength

  prev: ->
    @currentIndex-- if @currentIndex >= 0
  
  _getPoint: (index) ->
    { x: pointsX[index], y: pointsY[index] }

class Drawing
  constructor: ->


$ ->
  note = $("#note")
  note.on "touchstart", (e)->
    $("p#log").text("touch start")
    console.log(e)
  note.on "touchmove", (e)->
    $("p#log").text("touch move")
  note.on "touchend", (e)->
    $("p#log").text("touch end")
#$ ->
  #note_canvas = document.getElementById("note")
  #window.note_context = note_canvas.getContext("2d")

  #window.clickX = new Array()
  #window.clickY = new Array()
  #window.clickDrag = new Array()

  #$('#note').touchstart (e) ->
    #mouseX = e.pageX - this.offsetLeft
    #mouseY = e.pageY - this.offsetTop
    #window.paint = true

    #addClick(mouseX, mouseY)
    #window.redraw()

  #$('#note').touchmove (e) ->
    #if(window.paint)
      #mouseX = e.pageX - this.offsetLeft
      #mouseY = e.pageY - this.offsetTop
      #addClick(mouseX, mouseY, true)
      #window.redraw()

  #$('#note').touchend (e) ->
    #window.paint = false

  #$('#note').touchleave (e) ->
    #window.paint = false

  #window.addClick = (x, y, dragging)->
    #window.clickX.push(x)
    #window.clickY.push(y)
    #window.clickDrag.push(dragging)
  #window.redraw = ->
    #window.note_context.clearRect(0, 0, window.note_context.canvas.width, window.note_context.canvas.height)
    #window.note_context.strokeStyle = "#dddddd"
    #window.note_context.lineJoin = "round"
    #window.note_context.lineWidth = 10
    
    #for x, index in window.clickX
      #window.note_context.beginPath()
      #if window.clickDrag[index] && index != 0
        #note_context.moveTo(window.clickX[index-1], window.clickY[index-1])
      #else
        #note_context.moveTo(window.clickX[index]-1, window.clickY[index])
      #note_context.lineTo(window.clickX[index], window.clickY[index])
      #note_context.closePath()
      #note_context.stroke()


