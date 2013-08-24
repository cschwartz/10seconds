@MapOne = Map.extend
  description: ->
    cols = []
    for x in [0...@numCols]
      col = []
      for y in [0...@numRows]
        tileId = if @isBorder(x, y) then Map.ids.wall else Map.ids.empty
        col.push(tileId)
      cols.push(col)

    level = 
      cols: cols,
      items: [
#        {x: 1, y: 5, type: ChangeDirection, newDirection: 90},
        {x: 5, y: 5, type: ChangeDirection, newDirection: 180},
        {x: 5, y: 1, type: ChangeDirection, newDirection: 270},
        {x: 1, y: 1, type: ChangeDirection, newDirection: 0},
      ]
      inventory: [
        {type: ChangeDirection, newDirection: 90, amount: 1},
        {type: ChangeDirection, newDirection: 180, amount: 1},
        {type: ChangeDirection, newDirection: 90, amount: 1},
      ]
    level

  isBorder: (x, y) ->
    x == 0 || x == (@numCols - 1)|| y == 0 || y == (@numRows - 1)

MapOne.create = ->
  map = new MapOne()
  map.init()
  map


