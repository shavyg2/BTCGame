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
