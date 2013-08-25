@MapDemo = Map.extend
  description: ->
    level = 
      cols: @emptyMap()
      items: [
        {x: 2, y: 2, type: ChangeDirection, newDirection: 0},
        {x: 2, y: 8, type: ChangeDirection, newDirection: 90},
        {x: 13, y: 8, type: ChangeDirection, newDirection: 180},
        {x: 13, y: 2, type: ChangeDirection, newDirection: 270},
      ]
      inventory: [
      ]
      playerStart:
        x: 2
        y: 3
        rotation: 0
      nextLevel: MapOne
      isDemo: true
    level


MapDemo.create = ->
  map = new MapDemo()
  map.init()
  map


