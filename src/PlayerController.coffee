#include ./ButtonEvent.coffee

class PlayerController
  constructor:(player)->

    @init.call player
    @keypress=[]
    @interval=[]


  init:->
    @right= new ButtonEvent(@,39)
    @right.down= =>
      @x+=5

    @left= new ButtonEvent(@,37)
    @left.down= =>
      @x-=5

    @jump= new ButtonEvent(@,32)
    @jump.keypress=(key)=>
      @gravity+=@base_gravity
      @y+=@yV
      @y+=@gravity
      @y=Math.round(@y)

      if @y>@baseY
        window.clearInterval(key)
        eval('this').clear();
        @y=@baseY
        @gravity=0
















