@GameLayer = cc.Layer.extend
  init: (mapKlass) ->
    @_super()

    screenSize = cc.Director.getInstance().getWinSize()

    @map = mapKlass.create()
    @addChild(@map)

    @player = Player.create(@, @map, 1, 1)
    @addChild(@player)

    @timeGauge = TimeGauge.create(@)
    @addChild(@timeGauge)

    @itemBar = ItemBar.create(@, @map.getInventory())
    @addChild(@itemBar)

    @schedule(@update)

    @isRunning = false

    @label = cc.LabelTTF.create("3", "Times New Roman", 64, cc.c3b(255, 0, 0))
    @label.setPosition(cc.p(screenSize.width/2, screenSize.height*3/4))
    @label.setVisible(false)
    @addChild(@label)

    wait = cc.DelayTime.create(1)
    start = cc.CallFunc.create((-> @startLevel()), @)
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

    @runAction(action)

    @setTouchEnabled(true)
    true

  displayMessage: (text) ->
    if text
      @label.setVisible(true)
      @label.setString(text)
    else
      @label.setVisible(false)
    console.log(text)

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

  nextLevel: ->
    cc.Director.getInstance().replaceScene(TenSecondsScene.create(@map.getNextLevel()))

  update: (dt) ->
    if @isRunning
      @timeGauge.update(dt)

  timeEllapsed: ->
    @player.stopAllActions()

  createLevel: (levelName) ->
    true

  menuCloseCallback: (sender) ->
    true

  addItem: (x, y, type, description) ->
    @map.addItem(x, y, type, description)

  setCurrentInventory: (inventory) ->
    @currentInventory = inventory

  onTouchesBegan: (touches, events) ->
    if touches and @isRunning and  @currentInventory
      touch = touches[0]
      tap = touch.getLocation()
      @currentInventory.useAtLocation(Math.floor(tap.x / 64), Math.floor(tap.y / 64))
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
