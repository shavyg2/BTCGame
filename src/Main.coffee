#include World.coffee

canvas= document.getElementById("canvas")

world = new World(canvas)

p = new Player(10,50,200,200)
p.setWorld(world)
p.setFrame(70.2,120)
p.setFramePosition(3)


#world adding the player
world.addChild(p)
p.setImage("../resources/07gh_sim_tillerman_zpsa2af4431.jpg")
