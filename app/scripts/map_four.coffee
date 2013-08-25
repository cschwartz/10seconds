@MapFour = Map.extend
  description: ->
    base = @emptyMap()
    for y in [1..7]
      base[5][y] = Map.ids.wall
    for x in [6..11]
      base[x][7] = Map.ids.wall
    for x in [9..14]
      base[x][4] = Map.ids.wall
    base[11][9] = Map.ids.wall

    level = 
      cols: base
      items: [
        {x: 11, y: 8, type: SpeedUp, direction: -90},
        {x: 2, y: 2, type: Goal},
      ]
      inventory: [
        {type: ChangeDirection, newDirection: 180, amount: 1},
        {type: ChangeDirection, newDirection: 0, amount: 1},
        {type: ChangeDirection, newDirection: 90, amount: 1},
        {type: ChangeDirection, newDirection: 0, amount: 1},
        {type: ChangeDirection, newDirection: 270, amount: 1},
      ]
      playerStart:
        x: 14
        y: 2
        rotation: -90
      nextLevel: MapFive
    level


MapFour.create = ->
  map = new MapFour()
  map.init()
  map
