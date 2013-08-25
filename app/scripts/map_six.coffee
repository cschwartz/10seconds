@MapSix = Map.extend
  description: ->
    base = @emptyMap()
    for y in [4..6]
      for x in [1..14]
        base[x][y] = Map.ids.wall

    level = 
      cols: base
      items: [
        {x: 14, y: 8, type: PortalA, destinationX: 1, destinationY: 2},
        {x: 14, y: 2, type: Goal},
      ]
      inventory: [
        {type: PortalB, destinationX: 14, destinationY: 8},
      ]
      playerStart:
        x: 1
        y: 8
        rotation: 90
      nextLevel: MapSeven
    level


MapSix.create = ->
  map = new MapSix()
  map.init()
  map
