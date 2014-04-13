class DisplayObject
  constructor:(@x,@y,@width,@height)->
    @image=null

  setWorld:(@world)->

  setImage:(url)->
    @url=url
    console.log @world
    @image= @world.p.requestImage(@url)

  draw:->

