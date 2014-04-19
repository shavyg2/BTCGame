#include ./Enemy.coffee
#include ./PlayerController.coffee

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
