@MapOne = Map.extend
  description: ->
    level = 
      cols: @emptyMap()
      items: [
        {x: 1, y: 5, type: ChangeDirection, newDirection: 90},
        {x: 5, y: 5, type: Goal},
      ]
      inventory: [
      ]
      playerStart:
        x: 1
        y: 1
        rotation: 0
      nextLevel: MapTwo
    level


MapOne.create = ->
  map = new MapOne()
  map.init()
  map


