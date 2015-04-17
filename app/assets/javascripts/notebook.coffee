class @Notebook
  constructor: ({ painter: @painter, manager: @manager }) ->
    @noteIndex = 0
    @notebookSize = 1

  drawNote: (index) ->
    frames = @manager.getNoteFrames index
    painter.drawNewPicture frames
    @noteIndex = index

  drawNoteByTime: (index) ->
    frames = @manager.getNoteFrames index
    painter.drawNewPictureByTime frames
    @noteIndex = index

  drawNextNote: ->
    if @noteIndex > 0
      @drawNote --@noteIndex

  drawPrevNote: ->
    if @noteIndex < (@notebookSize - 1)
      @drawNote ++@noteIndex

  prevNote: ->
    if @manager.noteIndex > 0
      @painter.drawingFrames(@manager.changeNote(@manager.noteIndex - 1).noteFrame)

  nextNote: ->
    if @manager.noteIndex < @manager.noteSize - 1
      @painter.drawingFrames(@manager.changeNote(@manager.noteIndex + 1).noteFrame())

  increaseNotebookSize: ->
    @notebookSize++

  decreaseNotebookSize: ->
    @notebookSize--


