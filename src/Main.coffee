#include World.coffee

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
