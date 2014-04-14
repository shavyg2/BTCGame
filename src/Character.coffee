#include ./DisplayObject.coffee

class Character extends DisplayObject
  constructor:(x,y,width,height)->
    super(x,y,width,height)
    @base=y
    @frame=[]

    @_framePosition=1



  setFrame:(w,h)->
    @frameSize={"w":w,"h":h}



  setFramePosition:(position,yPosition,count,speed)->
    @_framePosition=position
    @_yPosition=yPosition
    @_frameCount=count
    @_speed=speed

  framePosition:->
    Math.floor(@_framePosition)%@_frameCount

  getFrameOverShoot:->
    x=@frameSize.w*@framePosition()
    x

  getFrameX:()->
    @frameSize.w*@framePosition()

  getFrameWidth:->
    @getFrameX()+@frameSize.w


  getFrameY:()->
    @_yPosition*@frameSize.h

  getFrameHeight:()->
    @frameSize.h

  X:->
    @x

  Y:->
    @y

  getFrame:(x,y)->
    if typeof @frame[x] is "undefined" or @frame[x] is null
      @frame[x]=[]
    if typeof @frame[x][y] is "undefined" or @frame[x][y] is null
      @frame[x][y]=@world.p.createImage(@width,@height)
      @frame[x][y].copy(@image,@getFrameX(),@getFrameY(),@frameSize.w,@frameSize.h,0,0,@width,@height)




    @frame[x][y]

  draw:()->

    if @image isnt null
      if @image.width isnt 0
        if typeof @frameSize isnt "undefined"
          @world.p.image(@getFrame(@_framePosition,@_yPosition),@X(),@Y())
        else
         @world.p.image(@image,@x,@y)










