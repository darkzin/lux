class @Player
  constructor: (painter) ->
    @painter = painter

  playRecording: (notes, notesTimeTable) ->
    @startPlayingTime = Date.now()
    @notes = notes
    @notesTimeTable = notesTimeTable
    @tableIndex = 0

    @currentNote = null
    @currentFrame = null

    @timer = setInterval =>
      @drawPicture()
    , 17

  drawPicture: ->
    elapsedTime = Date.now() - @startPlayingTime
    noteIsChanged = false

    while @tableIndex < @notesTimeTable.length and @notesTimeTable[@tableIndex].time < elapsedTime 
      noteIsChanged = true
      @currentNote = @notesTimeTable[@tableIndex++].note
    
    if noteIsChanged
      frames = @currentNote.getPrevFrames()
      @painter.drawNewPicture(frames) if frames
      @currentFrame = @currentNote.getCurrentFrame()

    @currentFrame = @currentNote.getCurrentFrame() unless @currentFrame?

    #console.log "currentNote playingIndex: #{@currentNote.playingIndex}"
    #console.log "currentNote frame length: #{@currentNote.frames.length}"
    #console.log "currentFrame time: #{@currentFrame.time}" if @currentFrame
    #console.log "elapsedTime : #{elapsedTime}"
    frames = []
    while @currentFrame? and @currentFrame.time < elapsedTime
      frames.push @currentFrame
      @currentFrame = @currentNote.getCurrentFrame()

    @painter.drawPicture(frames) if frames.length > 0