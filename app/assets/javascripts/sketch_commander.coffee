#= require jquery
#= require note
#= require painter
#= require manager
#= require player
#= require canvas

$.fn.sketchCommander = (key, args...)->
  $.error('SketchCommander.js can only be called on one element at a time.') if this.length > 1
  sketch = this.data('sketch')

  if typeof(key) == 'string' && sketch
    if sketch[key]
      if typeof(sketch[key]) == 'function'
        sketch[key].apply sketch, args
      else if args.length == 0
        sketch[key]
      else if args.length == 1
        sketch[key] = args[0]
    else
      $.error('Sketch.js did not recognize the given command.')
  else if sketch
    sketch
  else
    canvas = new Canvas
      canvasElement: this.get(0)
    painter = new Painter this.get(0)
    manager = new Manager
    player = new Player painter

    canvas.addObservers [painter, manager]
    this.data('sketch', canvas)
    src = "temp.wmv"
    recordingSuccess = ->
      console.log "recording success."
    recordingError = ->
      console.log "recording error."
    #console.log Media.to_string()
    #media = new Media(src, recordingSuccess, recordingError)

    $('body').delegate "a[href=\'##{$(this).attr('id')}\']", 'click', (e)->
      e.preventDefault()
      $this = $(this)
      $canvas = $($this.attr('href'))
      sketch = $canvas.data('sketch')
      for key in ['color', 'size', 'tool']
        if $this.attr("data-#{key}")
          sketch.set key, $(this).attr("data-#{key}")
      
      switch $this.attr("data-role")
        when "prev-note"
          note = manager.prevNote() 
        when "next-note"
          note = manager.nextNote()
        when "new-note"
          note = manager.createNote()
        when "start-recording"
          console.log "haha!!"
          manager.startRecording()
          #media.startRecord()
        when "stop-recording"
          manager.stopRecording()
          #media.stopRecord()
        when "play-recording"
          player.playRecording manager.getNotes(), manager.getNotesTimeTable()
          #media.play()
        when "stop-playing"
          player.stopPlaying()

      if note?
        painter.drawNewPicture(note.getFrames())
      #if $(this).attr('data-download')
        #sketch.download $(this).attr('data-download')

    return this

