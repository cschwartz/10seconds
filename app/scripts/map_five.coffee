@MapFive = Map.extend
  description: ->
    base = @emptyMap()
    for x in [1..12]
      base[x][6] = Map.ids.wall
    for x in [6..14]
      base[x][3] = Map.ids.wall
    for y in [3..5]
      base[3][y] = Map.ids.wall

    level = 
      cols: base
      items: [
        {x: 2, y: 3, type: SpeedUp, direction: 0},
        {x: 1, y: 8, type: Goal},

        {x: 13, y:5, type: ChangeDirection, newDirection: 0, amount: 1},
        {x: 2, y: 4, type: ChangeDirection, newDirection: 270, amount: 1},
        {x: 1, y: 4, type: ChangeDirection, newDirection: 180, amount: 1},
      ]
      inventory: [
        {x: 13, y:8, type: ChangeDirection, newDirection: 270, amount: 1},
        {x: 5, y: 5, type: ChangeDirection, newDirection: 90, amount: 1},
        {x:1, y: 1, type: ChangeDirection, newDirection: 90, amount: 1},
        {x: 2, y: 2, type: ChangeDirection, newDirection: 0, amount: 1},
        {x: 5, y: 1, type: ChangeDirection, newDirection: 0, amount: 1},

      ]
      playerStart:
        x: 14
        y: 2
        rotation: 270
      nextLevel: MapSix
    level


MapFive.create = ->
  map = new MapFive()
  map.init()
  map
