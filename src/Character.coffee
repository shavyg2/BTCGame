#include ./DisplayObject.coffee

class Character extends DisplayObject
  constructor:(x,y,width,height)->
    super(x,y,width,height)
    @frame=null
    @framePosition=1



  setFrame:(w,h)->
    @frameSize={"w":w,"h":h}

  setFramePosition:(position)->
    @framePosition=position

  getFrameOverShoot:->
    x=@frameSize.w*@framePosition
    x

  getFrameX:()->
    x=@getFrameOverShoot()
    if x > @image.width
      x%=@image.width
    x

  getFrameY:()->
    x=parseInt(@getFrameOverShoot()/@image.width)
    x+=@frameSize.h


  draw:()->
    if @image isnt null
      if @image.width isnt 0
        if typeof @frameSize isnt "undefined"

          document.getElementById("info").innerHTML="#{@x},#{@y}, #{@getFrameX()},#{@getFrameY()}"

          @frame=@world.p.copy(@image,0,0,@getFrameX(),@getFrameY(),@x,@y,@getFrameX(),@getFrameY())
        else
         @world.p.image(@image,@x,@y)









