class @Manager
  constructor: ->
    @notes = []
    @currentNoteIndex = -1
    @noteSize = 0
    @createNote()
    @isRecording = false

  startDrawing: (stroke) ->
    if @isPainting
      throw new Error "#startDrawing could not called in a row. plz call after #endDrawing."

    @isPainting = true

    if @isRecording
      stroke.time = Date.now() - @startTime

    @getCurrentNote().addStroke stroke

  drawing: (point) ->
    unless @isPainting
      throw new Error "#drawing must be called after #startDrawing is called."

    if @isRecording
      point.time = Date.now() - @startTime
    @getCurrentNote().addPoint point

  endDrawing: ->
    unless @isPainting
      throw new Error "#endDrawing must be called after #startDrawing is called."

    @isPainting = false

  getNote: (noteIndex) ->
    return @notes[noteIndex]

  getNotes: ->
    return @notes

  getCurrentNote: ->
    return @notes[@currentNoteIndex]

  createNote: ->
    newNote = new Note
    @currentNoteIndex = @notes.length
    @notes.push newNote

    if @isRecording
      newNote.startRecording()
      @notesTimeTable.push
        note: newNote
        time: Date.now() - @startTime

    return newNote

  changeNote: (index) ->
    if index < 0 or index >= @notes.length
      throw new Error "note index is out of range."
    
    if @isRecording
      @notesTimeTable.push
        note: @notes[index]
        time: Date.now() - @startTime

    @currentNoteIndex = index
    return @notes[index]

  prevNote: ->
    if @currentNoteIndex > 0
      @currentNoteIndex--
      return @changeNote @currentNoteIndex
    else
      return null

  nextNote: ->
    if @currentNoteIndex < (@notes.length - 1)
      @currentNoteIndex++
      return @changeNote @currentNoteIndex
    else
      return null

  getNoteIndex: ->
    @currentNoteIndex

  getNoteFrames: (index) ->
    noteFrames = []
    noteIndex = 0

    for frame in @frames
      if frame.type == "note"
        noteIndex = frame.index
      else if noteIndex == index
        noteFrames.push frame

    return noteFrames

  getStartTime: ->
    return @startTime

  getNotesTimeTable: ->
    return @notesTimeTable

  startRecording: ->
    @notesTimeTable = []
    @startTime = Date.now()

    for note in @notes
      note.startRecording()

    @notesTimeTable.push
      note: @getCurrentNote()
      time: 0
    @isRecording = true

  stopRecording: ->
    @isRecording = false