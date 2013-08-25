@MapEight = Map.extend
  description: ->
    base = @emptyMap()

    for y in [1..9]
        base[3][y] = Map.ids.wall

    for x in [4..11]
        base[x][7] = Map.ids.wall

    for x in [5..15]
        base[x][4] = Map.ids.wall

    for y in [2..3]
        base[13][y] = Map.ids.wall

    level = 
      cols: base
      items: [
        {x: 2, y: 8, type: PortalA, destinationX: 1, destinationY: 2},
        {x: 14, y: 3, type: Goal},
        {x:14, y: 1, type: ChangeDirection, newDirection: 0}
        {x: 12, y: 8, type: ChangeDirection, newDirection: 180}
        {x: 2, y: 6, type: SpeedUp, direction: 180},
      ]
      inventory: [
        {x: 4, y: 5, type: PortalB, destinationX: 14, destinationY: 8},
        {type: ChangeDirection, newDirection: 90}
        {type: ChangeDirection, newDirection: 180}
        {type: ChangeDirection, newDirection: 270}
        {type: ChangeDirection, newDirection: 180}
        {type: ChangeDirection, newDirection: 0}
      ]
      playerStart:
        x: 4
        y: 8
        rotation: 90
    level


MapEight.create = ->
  map = new MapEight()
  map.init()
  map
