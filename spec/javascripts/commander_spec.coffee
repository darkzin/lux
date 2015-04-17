#=require jquery
#=require sinon
#=require canvas
#=require sketch_commander

describe "Canvas,", ->
  beforeEach ->
    $("body#konacha").append("<canvas id='sketch'></canvas>")
    $("body#konacha").append("<a id='select-color-black' href='#sketch' data-color='black'>Black</a>")
    $("body#konacha").append("<a id='select-color-red' href='#sketch' data-color='red'>Red</a>")
    $("body#konacha").append("<a id='select-color-green' href='#sketch' data-color='green'>Green</a>")
    $("body#konacha").append("<a id='select-color-blue' href='#sketch' data-color='blue'>Blue</a>")

    $("body#konacha").append("<a id='select-size-three' href='#sketch' data-size='5'>5</a>")
    $("body#konacha").append("<a id='select-size-ten' href='#sketch' data-size='10'>10</a>")
    $("body#konacha").append("<a id='select-size-fifteen' href='#sketch' data-size='15'>15</a>")

    $("body#konacha").append("<a id='record' href='#sketch' data-role='record'>record</a>")

    $("body#konacha").append("<a id='note-prev' href='#sketch' data-role='prev-note'>record</a>")
    $("body#konacha").append("<a id='note-next' href='#sketch' data-role='next-note'>record</a>")

    @el = $($("canvas#sketch")[0])
    canvas  = @el.sketchCommander()
    @canvas = canvas.data 'sketch'
    
  it "should change color when color is selected by button on view.", ->
    redButton = $("body#konacha a#select-color-red")
    redButton.trigger("click")
    @canvas.color.should.be.equal "red"

  it "should change size when size is selected by button on view", ->
    threeSizeButton = $("body#konacha a#select-size-three")
    threeSizeButton.trigger("click")
    @canvas.size.should.be.equal "5"

  it "should delivery canvas event to object what is registered.", ->
    spy = sinon.spy()
    observer = { startDrawing: spy }
    @canvas.addObserver observer
    @el.trigger "mousedown", { pageX: 20, pageY: 30 }
    spy.called.should.be.true