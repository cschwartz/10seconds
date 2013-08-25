@MapTwo = Map.extend
  description: ->
    level = 
      cols: @emptyMap()
      items: [
        {x: 14, y: 3, type: Goal},
      ]
      inventory: [
        {type: ChangeDirection, newDirection: 180, amount: 1},
      ]
      playerStart:
        x: 1
        y: 8
        rotation: 90
      nextLevel: MapTwo
    level


MapTwo.create = ->
  map = new MapThree()
  map.init()
  map


