#= require note

describe "Note, ", ->
  beforeEach ->
    @note = new Note

  it "should return frames what is added before.", ->
    @note.addStroke
      color: "red"
      size: 5
      x: 20
      y: 30

    @note.addPoint
      x: 21
      y: 30

    frames = @note.getFrames()
    
    frames[0].should.be.eql
      type: "stroke"
      color: "red"
      size: 5

    frames[1].should.be.eql
      type: "point"
      x: 20
      y: 30

    frames[2].should.be.eql
      type: "point"
      x: 21
      y: 30

  it "should raise error when point add before stroke create.", ->
    note = @note
    fn = ->
      note.addPoint
        x: 20
        y: 30

    fn.should.throw "Point should add after stroke create."
