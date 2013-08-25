@GameLayer = cc.LayerColor.extend
  init: (mapKlass) ->
    @_super()
    @setColor(cc.c3b(149, 165, 166))

    @mapKlass = mapKlass
    @map = mapKlass.create()
    @addChild(@map)

    @player = Player.create(@, @map)
    @addChild(@player)

    @isDemo = @map.isDemoMode()

    @createLabel()

    if not @isDemo
      @timeGauge = TimeGauge.create(@)
      @addChild(@timeGauge)

      @itemBar = ItemBar.create(@, @map.getInventory())
      @addChild(@itemBar)
    else
      @displayMessage("Click to Start")



    @schedule(@update)

    @isRunning = false

    @beginCountdown()

    @setTouchEnabled(true)
    true

  createLabel: ->
    screenSize = cc.Director.getInstance().getWinSize()

    @label = cc.LabelTTF.create("3", "Montserrat", 64)
    @label.setColor(cc.c3b(192, 57, 43))
    @label.setPosition(cc.p(screenSize.width/2, screenSize.height/2))
    @label.setVisible(false)
    @addChild(@label)

  beginCountdown: ->
    start = cc.CallFunc.create((-> @startLevel()), @)
    if not @isDemo
      wait = cc.DelayTime.create(1)
      action = cc.Sequence.create([
        cc.CallFunc.create((-> @displayMessage("3")), @)
        wait.copy()
        cc.CallFunc.create((-> @displayMessage("2")), @)
        wait.copy()
        cc.CallFunc.create((-> @displayMessage("1")), @)
        wait.copy()
        cc.CallFunc.create((-> @displayMessage("Go")), @)
        wait.copy()
        cc.CallFunc.create((-> @displayMessage(undefined)), @)
        start
      ])
    else
      action = start

    @runAction(action)

  displayMessage: (text) ->
    if text
      @label.setVisible(true)
      @label.setString(text)
    else
      @label.setVisible(false)

  startLevel: ->
    @isRunning = true
    @player.moveForward()

  levelComplete: ->
    @isRunning = false
    wait = cc.DelayTime.create(2)
    progessToNextLevel = cc.CallFunc.create((-> @nextLevel()), @)
    action = cc.Sequence.create([
      cc.CallFunc.create((-> @displayMessage("Stage Complete")), @)
      wait
      progessToNextLevel
    ])

    @runAction(action)

  retryLevel: ->
    cc.Director.getInstance().replaceScene(TenSecondsScene.create(@mapKlass))

  nextLevel: ->
    nextMap = @map.getNextLevel()
    if nextMap
      cc.Director.getInstance().replaceScene(TenSecondsScene.create(@map.getNextLevel()))
    else
      cc.Director.getInstance().replaceScene(EndgameScene.create())

  update: (dt) ->
    if @isRunning and not @isDemo
      @timeGauge.update(dt)

  timeEllapsed: ->
    @player.stopAllActions()
    @isRunning = false
    wait = cc.DelayTime.create(2)
    retryCurrentLevel = cc.CallFunc.create((-> @retryLevel()), @)
    action = cc.Sequence.create([
      cc.CallFunc.create((-> @displayMessage("Time Over")), @)
      wait
      retryCurrentLevel
    ])

    @runAction(action)


  createLevel: (levelName) ->
    true

  menuCloseCallback: (sender) ->
    true

  addItem: (x, y, type, description) ->
    @map.addItem(x, y, type, description)

  setCurrentInventory: (inventory) ->
    @currentInventory = inventory

  onTouchesBegan: (touches, events) ->
    if @isDemo
      cc.Director.getInstance().replaceScene(TenSecondsScene.create(@map.getNextLevel()))
    else
      if touches and @isRunning and  @currentInventory
        touch = touches[0]
        tap = touch.getLocation()
        x = Math.floor(tap.x / 64)
        y = Math.floor(tap.y / 64)
        touch = touches[0]
        tap = touch.getLocation()
        @currentInventory.useAtLocation(x, y)
    true

  onTouchesMoved: (touches, event) ->
    true

  onTouchesEnded: (touches, event) ->
    true

  onTouchesCancelled: (touches, event) ->
    true

@TenSecondsScene = cc.Scene.extend
  init: (mapKlass) ->
    @_super()
    @mapKlass = mapKlass

  onEnter: ->
    @_super()
    layer = new GameLayer()
    layer.init(@mapKlass)
    @addChild(layer)

TenSecondsScene.create = (mapKlass) ->
  scene = new TenSecondsScene()
  scene.init(mapKlass)
  scene


EndgameLayer = cc.LayerColor.extend
  init: ->
    @_super()
    @setColor(cc.c3b(149, 165, 166))

    screenSize = cc.Director.getInstance().getWinSize()

    label = cc.LabelTTF.create("The End", "Montserrat Subrayada", 72)
    label.setColor(cc.c3b(0, 0, 0))
    label.setPosition(cc.p(screenSize.width/2, screenSize.height*3/4))
    @addChild(label)

    label = cc.LabelTTF.create("Thank you for playing, I hope you enjoyed it.", "Montserrat", 24)
    label.setColor(cc.c3b(0, 0, 0))
    label.setPosition(cc.p(screenSize.width/2, screenSize.height/2))
    @addChild(label)

    label = cc.LabelTTF.create("Click anywhere to restart.", "Montserrat", 24)
    label.setColor(cc.c3b(0, 0, 0))
    label.setPosition(cc.p(screenSize.width/2, screenSize.height/2 - 32))
    @addChild(label)
    @setTouchEnabled(true)

  onTouchesBegan: (touches, event) ->
    if touches
      cc.Director.getInstance().replaceScene(TenSecondsScene.create(MapDemo))

@EndgameScene = cc.Scene.extend
  init: (mapKlass) ->
    @_super()
  onEnter: ->
    @_super()
    layer = new EndgameLayer()
    layer.init()
    @addChild(layer)

EndgameScene.create = (mapKlass) ->
  scene = new EndgameScene()
  scene.init()
  scene
