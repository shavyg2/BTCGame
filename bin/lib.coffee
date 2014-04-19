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
    @image= @world.p.requestImage(@url)

  draw:->

  enterFrame:->





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
      @y += @yV
      @y += @gravity
      @y = Math.round(@y)

      if @y > @baseY
        window.clearInterval(key)
        eval('this').clear();
        @y = @baseY
        @gravity = 0
        p.setFramePosition(1, 0, 7, 0.015)



















class Enemy extends Character
  constructor:(x,y,w,h)->
    super(x,y,w,h)







class Player extends Enemy
  constructor:(x,y,w,h)->
    super(x,y,w,h)
    @control=new PlayerController(@)
    @yV=-40
    @baseY=y
    @base_gravity=0.1
    @gravity=0
    @flip=off
    @velocity=0




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




canvas= document.getElementById("canvas")

world = new World(canvas,document.body.clientWidth,document.body.clientHeight)

window.addEventListener("resize",->
  world.p.size(document.body.clientWidth,document.body.clientHeight)
,false)


base= document.body.clientHeight-150




###
  The Grass
###
for i in [0..Math.ceil(document.body.clientWidth/50)]
  e = new Character(i*200,base+80,300,300)
  e.setWorld(world)
  e.speed=0
  e.setFrame(150,150)
  e.setFramePosition(0,0,5,0)
  e.enterFrame= ->
    if @x <= -1000
      @x=document.body.clientWidth+500
    @x -=(@world.player.velocity || 0)

  #world adding the enemy
  e.setImage("../resources/grass.png")
  world.addChild(e)


###
  The Clouds
###
for i in [0..5]
  e = new Character(Math.random()*document.body.clientWidth,-350+(document.body.clientHeight/2)*Math.random(),500,500)
  e.setWorld(world)
  e.speed=Math.random()**3
  e.setFrame(270,270)
  e.setFramePosition(Math.round(Math.random()*4),0,4,0)
  e.enterFrame= ->
    if @x <= -500
      @x=document.body.clientWidth+Math.random()*400
    @x -=@speed+(@world.player.velocity || 0)

  #world adding the enemy
  e.setImage("../resources/clouds.png")
  world.addChild(e)




###
  The House
###
for i in [0..10]
  e = new Character(i*Math.random()*500*i,base-160,350,249)
  e.setWorld(world)
  e.speed=0
  e.setFrame(350,249)
  e.setFramePosition(0,0,5,0)
  e.enterFrame= ->
    if @x <= -5000
      @x=document.body.clientWidth+Math.random()*900
    @x -=(@world.player.velocity || 0)

  #world adding the enemy
  e.setImage("../resources/house.png")
  world.addChild(e)





for i in [0..2]
  e = new Enemy(Math.random()*5000+400,base+40,100,100)
  e.setWorld(world)
  e.speed=2
  e.setFrame(45,45)
  e.setFramePosition(0,0,5,0)
  e.enterFrame= ->
    if @x <-200
      @speed= Math.random()*5
      @x=document.body.clientWidth+500
    @x -=@speed+(@world.player.velocity || 0)

  #world adding the enemy
  e.setImage("../resources/monster-sprite.png")
  world.addChild(e)



p = new Player(10,base,90,135)
p.setWorld(world)
p.setFrame(90,135)
p.setFramePosition(0,1,7,0.000)

#world adding the player
world.addPlayer(p)
p.setImage("../resources/07gh_sim_tillerman_zpsa2af4431.png")

