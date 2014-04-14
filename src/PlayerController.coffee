#include ./ButtonEvent.coffee

class PlayerController
  constructor: (player)->
    @init.call player
    @keypress = []
    @interval = []


  init: ->
    @right = new ButtonEvent(@, 39)

    @right.down = =>
      @velocity= Math.round(World.timeLapse() * 0.5)
      @x += @velocity
      @flip=off

      if @base is @y
        @_framePosition += @_speed * World.timeLapse()

      if @_yPosition is 1 and @base is @y
        @setFramePosition(0, 0, 7, 0.015)

      @x = Math.min(100, @x)

    @right.up = =>
      @setFramePosition(0, 1, 5, 0.000)
      @velocity=0


    @left = new ButtonEvent(@, 37)
    @left.down = =>
      @flip=on
      @velocity= - Math.round(World.timeLapse() * 0.5)
      @x +=@velocity
      @x = Math.max(1, @x)

    @left.up = =>
      @setFramePosition(0, 1, 5, 0.000)
      @velocity=0


    @jump = new ButtonEvent(@, 32)
    @jump.keypress = (key)=>
      if @y is @base
        @setFramePosition(1, 1, 5, 0.007)
      else
        @_framePosition += @_speed * World.timeLapse()


      @gravity += @base_gravity * World.timeLapse()
      @y += @yV * World.timeLapse()
      @y += @gravity
      @y = Math.round(@y)

      if @y > @baseY
        window.clearInterval(key)
        eval('this').clear();
        @y = @baseY
        @gravity = 0
        p.setFramePosition(1, 0, 7, 0.015)
















