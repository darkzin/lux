class @Note
  constructor: ->
    @frames = []

    @playingIndex = null
    @recording = false

    @currentStroke = null

  addStroke: (stroke) ->
    strokeFrame = 
      type: "stroke"
      color: stroke.color
      size: stroke.size
    strokeFrame.time = stroke.time if stroke.time
    @frames.push strokeFrame

    pointFrame = 
      type: "point"
      x: stroke.x
      y: stroke.y
    pointFrame.time = stroke.time if stroke.time
    @frames.push pointFrame

  addPoint: (point) ->
    if @frames.length <= 0 or @frames[0].type != "stroke"
      throw new Error "Point should add after stroke create."

    pointFrame = 
      type: "point"
      x: point.x
      y: point.y
    pointFrame.time = point.time if point.time
    @frames.push pointFrame

  getFrames: ->
    return @frames

  getCurrentFrame: ->
    if @playingIndex < @frames.length
      frame = @frames[@playingIndex]
      @playingIndex++
      return frame
    else
      return null

  getPrevFrames: ->
    if @frames.length > 0
      frames = @frames.slice 0, @playingIndex
      return frames
    else
      return null

  startRecording: ->
    @playingIndex = @frames.length
