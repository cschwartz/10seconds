@MapThree = Map.extend
  description: ->
    base = @emptyMap()
    for y in [1..7]
      base[4][y] = Map.ids.wall
    for y in [4..9]
      base[8][y] = Map.ids.wall
    for x in [9..15]
      base[x][4] = Map.ids.wall

    level = 
      cols: base
      items: [
        {x: 14, y: 2, type: Goal},
      ]
      inventory: [
        {type: ChangeDirection, newDirection: 180, amount: 1},
        {type: ChangeDirection, newDirection: 90, amount: 1},
        {type: ChangeDirection, newDirection: 90, amount: 1},
      ]
      playerStart:
        x: 2
        y: 1
        rotation: 0
      nextLevel: MapThree
    level


MapThree.create = ->
  map = new MapThree()
  map.init()
  map


