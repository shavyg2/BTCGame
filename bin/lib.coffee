class ButtonEvent
  constructor:(@player,@keyCode)->
    @init()


  init:->
    window.addEventListener("blur",=>
      window.clearInterval((@player.control.interval[@keyCode]))
      window.clearInterval((@player.control.interval["#{@keyCode} tap"]))
      @player.control.keypress["#{@keyCode} tap"]="none"
      @player.control.keypress[@keyCode]="none"

    ,false)


    window.addEventListener("focus",=>
      window.clearInterval((@player.control.interval[@keyCode]))
      window.clearInterval((@player.control.interval["#{@keyCode} tap"]))
    ,false)

    document.addEventListener("keydown",(event)=>
      if event.keyCode is @keyCode and @player.control.keypress[@keyCode] isnt "down"
        @player.control.keypress[@keyCode]="down"
        @player.control.interval[@keyCode]=window.setInterval(@down,1000/60);
    ,false)

    document.addEventListener("keyup",(event)=>
      if event.keyCode is @keyCode
        @player.control.keypress[@keyCode]="none"
        window.clearInterval(@player.control.interval[@keyCode])
        @up()
    ,false)


    document.addEventListener("keypress",(event)=>

      event.keyCode=event.which

      code=Math.max(event.keyCode,event.which)

      if code is @keyCode and @player.control.keypress["#{@keyCode} tap"] isnt "down"
        @player.control.interval["#{@keyCode} tap"]= window.setInterval(=>
          @player.control.keypress["#{@keyCode} tap"]="down"
          @keypress.call(this,@player.control.interval["#{@keyCode} tap"])
        ,1000/60)
    )


  down:->

  up:->

  keypress:(key)->

  clear:->
    @player.control.keypress["#{@keyCode} tap"]="none"

class DisplayObject
  constructor:(@x,@y,@width,@height)->
    @image=null

  setWorld:(@world)->

  setImage:(url)->
    @url=url
    console.log @world
    @image= @world.p.requestImage(@url)

  draw:->




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



















class Enemy extends Character
  constructor:(x,y,w,h)->
    super(x,y,w,h)





class Player extends Enemy
  constructor:(x,y,w,h)->
    super(x,y,w,h)
    @control=new PlayerController(@)
    @yV=-10
    @baseY=y
    @base_gravity=0.5
    @gravity=0




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



canvas= document.getElementById("canvas")

world = new World(canvas)

p = new Player(10,50,200,200)
p.setWorld(world)
p.setFrame(70.2,120)
p.setFramePosition(3)


#world adding the player
world.addChild(p)
p.setImage("../resources/07gh_sim_tillerman_zpsa2af4431.jpg")

