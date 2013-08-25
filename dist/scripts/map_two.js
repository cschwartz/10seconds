// Generated by CoffeeScript 1.6.3
(function() {
  this.MapTwo = Map.extend({
    description: function() {
      var level;
      level = {
        cols: this.emptyMap(),
        items: [
          {
            x: 14,
            y: 3,
            type: Goal
          }
        ],
        inventory: [
          {
            type: ChangeDirection,
            newDirection: 180,
            amount: 1
          }
        ],
        playerStart: {
          x: 1,
          y: 8,
          rotation: 90
        },
        nextLevel: MapThree
      };
      return level;
    }
  });

  MapTwo.create = function() {
    var map;
    map = new MapTwo();
    map.init();
    return map;
  };

}).call(this);