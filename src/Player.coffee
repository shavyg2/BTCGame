#include ./Enemy.coffee
#include ./PlayerController.coffee

class Player extends Enemy
  constructor:(x,y,w,h)->
    super(x,y,w,h)
    @control=new PlayerController(@)
    @yV=-1.3
    @baseY=y
    @base_gravity=0.1
    @gravity=0
    @flip=off
    @velocity=0
