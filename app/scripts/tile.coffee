@Tile = cc.Sprite.extend
  init: (filename, x, y) ->
    @_super()
    @initWithFile(filename)
    @setPosition(cc.p(x * 64, y * 64))
    @setAnchorPoint(cc.p(0, 0))

    @items = []
    
  addItem: (item, description) ->
    newItem = item.create(description)
    @addChild(newItem)
    @items.push(newItem)
    if @currentPlayer
      @itemCompleted(@currentPlayer)
    true

  playerEntered: (player) ->
    @currentPlayer = player
    @currentItemIndex = 0
    @itemCompleted(player)

  itemCompleted: (player) ->
    if @currentItemIndex < @items.length
      currentItem = @items[@currentItem]
      @handleCurrentItem(player)
      @currentItemIndex++
    else
      if player.canMoveForward()
        @currentPlayer = undefined
        player.moveForward()

  handleCurrentItem: (player) ->
    @items[@currentItemIndex].interact(player, @)

  canEnter: ->
    true

@EmptyTile = Tile.extend
  init: (x, y) ->
    @_super(empty, x, y)

EmptyTile.create = (x, y) ->
  tile = new EmptyTile()
  tile.init(x, y)
  tile

@WallTile = Tile.extend
  init: (x, y) ->
    @_super(wall, x, y)

  addItem: (item, description) ->
    false

  canEnter: ->
    false

WallTile.create = (x, y) ->
  tile = new WallTile()
  tile.init(x, y)
  tile


