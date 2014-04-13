#include ./Enemy.coffee
#include ./PlayerController.coffee

class Player extends Enemy
  constructor:(x,y,w,h)->
    super(x,y,w,h)
    @control=new PlayerController(@)
    @yV=-10
    @baseY=y
    @base_gravity=0.5
    @gravity=0
