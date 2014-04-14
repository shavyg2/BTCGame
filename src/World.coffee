#include ./Player.coffee


class World
  constructor: (canvas,width=600,height=400)->
    console.log "created the world"
    @framerateContainer=document.getElementById("framerate")
    @child = []
    @p = new Processing canvas
    console.log "created the canvas"

    @p.size(width, height)
    console.log "created the background"
    @init()
    console.log "created the game loop"

  @timeLapse: ->
    f = World.enterFrame
    f[f.length - 1] - f[f.length - 2] || 0

  @enterFrame: []

  addPlayer:(@player)->

  addChild: (dp)->
    @child.push(dp)

  init: ->
    World.enterFrame.push(Date.now())
    if World.enterFrame.length > 20
      World.enterFrame.shift()

      @loop()
    window.requestAnimationFrame(=>
      @init()
    )


  loop: ->
    @p.background(135,206,250)
    for c in @child
      c.enterFrame()
      c.draw(@p)

    @player.draw(@p)

