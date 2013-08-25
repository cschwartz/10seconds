@Tile = cc.Sprite.extend
  init: (filename, x, y) ->
    @_super()
    @initWithFile(filename)
    @setPosition(cc.p(x * 64, y * 64))
    @setAnchorPoint(cc.p(0, 0))

    @position = cc.p(x, y)

    @items = []
    
  addItem: (item, description, map) ->
    newItem = item.create(description, map, @)
    @addChild(newItem)
    @items.push(newItem)
    if @currentPlayer
      @itemCompleted(@currentPlayer)
    newItem

  getPosition: ->
    @position

  playerEntered: (player) ->
    @currentPlayer = player
    @currentItemIndex = 0
    @itemCompleted()

  reprocessItems: ->
    if @currentPlayer
      @currentItemIndex = 0
      @itemCompleted()

  itemCompleted: ->
    if @currentItemIndex < @items.length
      currentItem = @items[@currentItem]
      @handleCurrentItem(@currentPlayer)
      @currentItemIndex++
    else
      if @currentPlayer.canMoveForward()
        player = @currentPlayer
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

  addItem: (item, description, map) ->
    false

  canEnter: ->
    false

WallTile.create = (x, y) ->
  tile = new WallTile()
  tile.init(x, y)
  tile


