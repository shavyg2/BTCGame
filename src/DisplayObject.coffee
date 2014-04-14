class DisplayObject
  constructor:(@x,@y,@width,@height)->
    @image=null

  setWorld:(@world)->

  setImage:(url)->
    @url=url
    @image= @world.p.requestImage(@url)

  draw:->

  enterFrame:->


