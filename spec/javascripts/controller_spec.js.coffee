#= require jquery
#= require controller
class Controller
  constructor: (canvasElement) ->
    @touched = false
    @canvas = canvasElement
    @context = @canvas.getContext("2d")
    @addListeners(@canvas)

  addListeners: (element) ->
    element.addEventListener("mousedown", @touchStart, false)
    element.addEventListener("mousemove", @touchMove, false)
    element.addEventListener("mouseup", @touchEnd, false)

  touchStart: (event) =>
    @touched = true
    @fromX = event.clientX
    @fromY = event.clientY
    #console.log("touch start." + event)

  touchMove: (event) =>
    if @touched
      toX = event.pageX - @canvas.offsetLeft
      toY = event.pageY - @canvas.offsetTop
      console.log("fromX: #{@fromX}, fromY: #{@fromY}")
      console.log("X: #{toX}, Y: #{toY}")
      @context.moveTo(@fromX, @fromY)
      @context.lineTo(toX, toY)
      @context.stroke()
      @fromX = toX
      @fromY = toY
    #console.log("touch move." + event) if @touched?

  touchEnd: (event) =>
    @touched = false
    #console.log("touch end." + event)


describe "when touchstart event raised,", ->
  describe "Controller", ->
    it "should have received the event", ->
      canvas = document.createElement("CANVAS")
      canvas.id = "canvas"
      document.getElementById("konacha").appendChild(canvas)
      canvas.style = "border: 1px solid #ddd; width: 500px; height: 500px;"
      context = canvas.getContext("2d")
      controller = new Controller(canvas)
      #event = new Event("mousedown")
      #canvas.dispatchEvent(event)
      controller.toucded.should.be.true