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
    if @game.addItem(x, y, @description.type,  @description)
      @description.available = false
      @setEnabled(false)
      @setSelectedIndex(2)
      @icon.setOpacity(127)
      @game.setCurrentInventory(undefined)
    true

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


