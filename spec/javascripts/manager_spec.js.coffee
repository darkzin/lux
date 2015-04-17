#= require jquery
#= require manager
#= require note

describe "Manager", ->
  beforeEach ->
    @manager = new Manager

  it "should raise error if drawing is called before startDrawing is called.", ->
    @manager.drawing.should.throw "#drawing must be called after #startDrawing is called."

  it "should raise error if #endDrawing is called before #startDrawing is called.", ->
    @manager.endDrawing.should.throw "#endDrawing must be called after #startDrawing is called."

  it "should raise error if #startDrawing is called in a row.", ->
    @manager.startDrawing
      color: "red"
      size: 5
      x: 10
      y: 20
    manager = @manager
    fn = ->
      manager.startDrawing
        color: "blue"
        size: 10
        x: 20
        y: 30
    fn.should.throw "#startDrawing could not called in a row. plz call after #endDrawing."

  it "should have stroke and point on frames when startDrawing function is called.", ->
    @manager.startDrawing
      color: "red"
      size: 5
      x: 20
      y: 30

    frames = @manager.getCurrentNote().getFrames()
    frames[0].should.be.eql
      type: "stroke"
      color: "red"
      size: 5
    
    frames[1].should.be.eql
      type: "point"
      x: 20
      y: 30

  xit "should set time attr to point if #startDrawing is called with time attr.", ->
    @manager.startDrawing
      color: "red"
      size: 5
      x: 20
      y: 30
      time: 20

    frames = @manager.getCurrentNote().getFrames()
    frames[1].should.be.eql
      type: "point"
      x: 20
      y: 30
      time: 20

  it "frames should have point of last movement when #drawing is called.", ->
    @manager.startDrawing
      color: "red"
      size: 5
      x: 20
      y: 30
 
    @manager.drawing
      x: 21
      y: 30

    frames = @manager.getCurrentNote().getFrames()
    frames[2].should.be.eql
      type: "point"
      x: 21
      y: 30

  it "note that returned should be currentNote.", ->
    note = @manager.createNote()
    note.should.be.equal @manager.getCurrentNote()

  it "#changeNote should change note.", ->
    @manager.createNote()
    @manager.getNoteIndex().should.be.equal(1)
    @manager.changeNote(0)
    @manager.getNoteIndex().should.be.equal(0)

  it "raise error if changeNote index is out of range.", ->
    @manager.createNote()
    manager = @manager
    fn = ->
      manager.changeNote(2)
    fn.should.throw "note index is out of range."

  it "when note is changed, #noteFrames should return all frame of note.", ->
    @manager.startDrawing
      color: "red"
      size: 5
      x: 20
      y: 30
 
    @manager.drawing
      x: 21
      y: 30

    @manager.drawing
      x: 22
      y: 30

    @manager.endDrawing()

    @manager.createNote()
    @manager.startDrawing
      color: "red"
      size: 5
      x: 20
      y: 30
    @manager.endDrawing()

    @manager.changeNote(0)
    @manager.startDrawing
      color: "blue"
      size: 10
      x: 23
      y: 30
    @manager.endDrawing()

    noteFrames = @manager.getNote(0).getFrames()

    noteFrames[0].should.be.eql
      type: "stroke"
      color: "red"
      size: 5

    noteFrames[1].should.be.eql
      type: "point"
      x: 20
      y: 30

    noteFrames[2].should.be.eql
      type: "point"
      x: 21
      y: 30

    noteFrames[3].should.be.eql
      type: "point"
      x: 22
      y: 30

    noteFrames[4].should.be.eql
      type: "stroke"
      color: "blue"
      size: 10

    noteFrames[5].should.be.eql
      type: "point"
      x: 23
      y: 30