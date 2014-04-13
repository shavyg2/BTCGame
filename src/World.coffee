#include ./Player.coffee


class World
   constructor:(canvas)->
     console.log "created the world"

     @child=[]
     @p=new Processing canvas
     console.log "created the canvas"

     @p.size(600,300)
     @p.background(100)
     console.log "created the background"
     @init()
     console.log "created the game loop"


   addChild:(dp)->
     @child.push(dp)

   init:->
     @loop()
     window.requestAnimationFrame(=>
      @init()
     )


   loop:->
    @p.background(255)
    for c in @child
      c.draw(@p)
