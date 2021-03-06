// Generated by CoffeeScript 1.6.3
(function() {
  this.MapFour = Map.extend({
    description: function() {
      var base, level, x, y, _i, _j, _k;
      base = this.emptyMap();
      for (y = _i = 1; _i <= 7; y = ++_i) {
        base[5][y] = Map.ids.wall;
      }
      for (x = _j = 6; _j <= 11; x = ++_j) {
        base[x][7] = Map.ids.wall;
      }
      for (x = _k = 9; _k <= 14; x = ++_k) {
        base[x][4] = Map.ids.wall;
      }
      base[11][9] = Map.ids.wall;
      level = {
        cols: base,
        items: [
          {
            x: 11,
            y: 8,
            type: SpeedUp,
            direction: -90
          }, {
            x: 2,
            y: 2,
            type: Goal
          }
        ],
        inventory: [
          {
            type: ChangeDirection,
            newDirection: 180,
            amount: 1
          }, {
            type: ChangeDirection,
            newDirection: 0,
            amount: 1
          }, {
            type: ChangeDirection,
            newDirection: 90,
            amount: 1
          }, {
            type: ChangeDirection,
            newDirection: 0,
            amount: 1
          }, {
            type: ChangeDirection,
            newDirection: 270,
            amount: 1
          }
        ],
        playerStart: {
          x: 14,
          y: 2,
          rotation: -90
        },
        nextLevel: MapFive
      };
      return level;
    }
  });

  MapFour.create = function() {
    var map;
    map = new MapFour();
    map.init();
    return map;
  };

}).call(this);
