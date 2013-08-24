@InventoryItem = cc.MenuItemToggle.extend
  init: (game, itemBar, description) ->
    @game = game
    @itemBar = itemBar
    @description = description

    button_unpressed_item = cc.MenuItemSprite.create(cc.Sprite.create(button_unpressed))
    button_pressed_item = cc.MenuItemSprite.create(cc.Sprite.create(button_pressed))
    button_disabled_item = cc.MenuItemSprite.create(cc.Sprite.create(button_disabled))

    @initWithItems([button_unpressed_item, button_pressed_item, button_disabled_item, (-> @buttonPressed()), @])

    if not description
      @setSelectedIndex(2)
      @setEnabled(false)
    else
      @description.available = true
      @icon = description.type.createIcon(description)
      @addChild(@icon, 1)
      true

  useAtLocation: (x, y) ->
    @game.addItem(x, y, @description.type,  @description)
    @description.available = false
    @setEnabled(false)
    @setSelectedIndex(2)
    @icon.setOpacity(127)
    @game.setCurrentInventory(undefined)

  disable: ->
    if @description.available
      @setSelectedIndex(0)

  buttonPressed: ->
    if @getSelectedIndex() == 1
      @itemBar.selected(@)
      @game.setCurrentInventory(@)
    else
      @itemBar.selected(undefined)
      @game.setCurrentInventory(undefined)
      @setSelectedIndex(0)

InventoryItem.create = (game, menu, description) ->
  item = new InventoryItem()
  item.init(game, menu, description)
  item

@ItemBar = cc.Node.extend
  init: (game, inventory) ->
    @_super()

    @game = game

    screenSize = cc.Director.getInstance().getWinSize()
    @menu = cc.Menu.create()
    @addChild(@menu)

    @menu.setPosition(screenSize.width / 2, screenSize.height - 32)

    for i in [0...16]
      item = InventoryItem.create(game, @, inventory[i])
      @menu.addChild(item)

    @menu.alignItemsHorizontallyWithPadding(0)

  selected: (item) ->
    if @selectedItem
      @selectedItem.disable()

    @selectedItem = item
      
ItemBar.create = (game, inventory) ->
  itemBar = new ItemBar()
  itemBar.init(game, inventory)
  itemBar

@TimeGauge = cc.Node.extend
  init: (game) ->
    @_super()

    @game = game

    @totalTime = 10
    @currentTime = @totalTime

    @drawing = new cc.DrawingPrimitiveWebGL()
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
