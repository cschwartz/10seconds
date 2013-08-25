@MapSeven = Map.extend
  description: ->
    base = @emptyMap()

    base[4][3] = Map.ids.wall
    base[4][4] = Map.ids.wall
    base[4][6] = Map.ids.wall
    base[4][7] = Map.ids.wall

    for y in [1..9]
      if y != 5
        base[9][y] = Map.ids.wall

    level = 
      cols: base
      items: [
        {x: 9, y: 5, type: PortalA, destinationX: 1, destinationY: 2},
        {x: 4, y: 5, type: PortalB, destinationX: 14, destinationY: 8},
        {x: 14, y: 5, type: Goal},
      ]
      inventory: [
        {type: ChangeDirection, newDirection: 90}
        {type: ChangeDirection, newDirection: 180}
        {type: ChangeDirection, newDirection: 270}
        {type: ChangeDirection, newDirection: 0}
      ]
      playerStart:
        x: 6
        y: 5
        rotation: 90
      nextLevel: MapEight
    level


MapSeven.create = ->
  map = new MapSeven()
  map.init()
  map
