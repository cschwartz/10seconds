@TimeGauge = cc.Node.extend
  init: (game) ->
    @_super()

    @game = game

    @totalTime = 10
    @currentTime = @totalTime

    @drawing = new (if sys.capabilities.opengl then cc.DrawingPrimitiveWebGL else cc.DrawingPrimitiveCanvas)()
    @screenSize = cc.Director.getInstance().getWinSize()

  update: (dt) ->
    @currentTime -= dt
    if @currentTime < 0
      @currentTime = 0 
      @game.timeEllapsed()

  draw: ->
    colorBackground = new cc.c4f(52/255, 73/255, 94/255, 255/255)
    colorEnergy = new cc.c4f(52/255, 152/255, 219/255, 255/255)
    @drawing.drawSolidRect(cc.p(16, 16), cc.p(@screenSize.width - 16, 48), colorBackground)
    @drawing.drawSolidRect(cc.p(20, 20), cc.p(20 + ((@currentTime) / @totalTime) * (@screenSize.width - 40), 44), colorEnergy)
    for i in [1...10]
      @drawing.drawSolidRect(cc.p(16 + (@screenSize.width - 32)*i/10 - 2, 20), cc.p(16 + (@screenSize.width - 32)*i/10 + 2, 44), colorBackground)
    true

TimeGauge.create = (game) ->
  timeGauge = new TimeGauge(game)
  timeGauge.init(game)
  timeGauge


