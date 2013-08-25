@Map = cc.Node.extend
  init: ->
    @_super()

    @numCols = 16
    @numRows = 11

    desc = @description()
    @tiles = []
    for x in [0...16]
      column = []
      row = desc.cols[x]
      for y in [0...11]
        tileId = row[y]
        tileKlass = @idToTile(tileId)
        tile = tileKlass.create(x, y)
        @addChild(tile)
        column.push(tile)
      @tiles.push(column)

    for item in desc.items
      x = item.x
      y = item.y
      type = item.type
      tile = @tiles[x][y].addItem(type, item)
    
    @inventory = desc.inventory
    @nextLevel = desc.nextLevel
    @playerStart = desc.playerStart

  playerCanMoveForward: (player) ->
    newPosition = player.getNextTilePosition()
    nextTile = @tiles[newPosition.x][newPosition.y]
    nextTile.canEnter()


  playerMoveCompleted: (player) ->
    currentPosition = player.getTilePosition()
    currentTile = @tiles[currentPosition.x][currentPosition.y]
    currentTile.playerEntered(player)
  
  addItem: (x, y, type, item) ->
    @tiles[x][y].addItem(type, item)


  idToTile: (id) ->
    switch id
      when Map.ids.empty then EmptyTile
      when Map.ids.wall then WallTile

  getNextLevel: ->
    @nextLevel

  getInventory: ->
    @inventory

  getPlayerStart: ->
    @playerStart

  isBorder: (x, y) ->
    x == 0 || x == (@numCols - 1)|| y == 0 || y == (@numRows - 1)

  emptyMap: ->
    cols = []
    for x in [0...@numCols]
      col = []
      for y in [0...@numRows]
        tileId = if @isBorder(x, y) then Map.ids.wall else Map.ids.empty
        col.push(tileId)
      cols.push(col)
    cols


@Map.ids = {
  empty: 0,
  wall: 1
}

@Map.create = (mapJson)->
  map = new Map()
  map.init()
  map


