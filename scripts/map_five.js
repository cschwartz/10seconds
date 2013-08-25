// Generated by CoffeeScript 1.6.3
(function() {
  this.MapFive = Map.extend({
    description: function() {
      var base, level, x, y, _i, _j, _k;
      base = this.emptyMap();
      for (x = _i = 1; _i <= 12; x = ++_i) {
        base[x][6] = Map.ids.wall;
      }
      for (x = _j = 6; _j <= 14; x = ++_j) {
        base[x][3] = Map.ids.wall;
      }
      for (y = _k = 3; _k <= 5; y = ++_k) {
        base[3][y] = Map.ids.wall;
      }
      level = {
        cols: base,
        items: [
          {
            x: 2,
            y: 3,
            type: SpeedUp,
            direction: 0
          }, {
            x: 1,
            y: 8,
            type: Goal
          }, {
            x: 13,
            y: 5,
            type: ChangeDirection,
            newDirection: 0,
            amount: 1
          }, {
            x: 2,
            y: 4,
            type: ChangeDirection,
            newDirection: 270,
            amount: 1
          }, {
            x: 1,
            y: 4,
            type: ChangeDirection,
            newDirection: 180,
            amount: 1
          }
        ],
        inventory: [
          {
            x: 13,
            y: 8,
            type: ChangeDirection,
            newDirection: 270,
            amount: 1
          }, {
            x: 5,
            y: 5,
            type: ChangeDirection,
            newDirection: 90,
            amount: 1
          }, {
            x: 1,
            y: 1,
            type: ChangeDirection,
            newDirection: 90,
            amount: 1
          }, {
            x: 2,
            y: 2,
            type: ChangeDirection,
            newDirection: 0,
            amount: 1
          }, {
            x: 5,
            y: 1,
            type: ChangeDirection,
            newDirection: 0,
            amount: 1
          }
        ],
        playerStart: {
          x: 14,
          y: 2,
          rotation: 270
        },
        nextLevel: MapSix
      };
      return level;
    }
  });

  MapFive.create = function() {
    var map;
    map = new MapFive();
    map.init();
    return map;
  };

}).call(this);
