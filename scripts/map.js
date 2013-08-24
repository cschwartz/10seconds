// Generated by CoffeeScript 1.6.3
(function() {
  this.Map = cc.Node.extend({
    init: function() {
      var column, desc, item, row, tile, tileId, tileKlass, type, x, y, _i, _j, _k, _len, _ref;
      this._super();
      this.numCols = 16;
      this.numRows = 11;
      desc = this.description();
      this.tiles = [];
      for (x = _i = 0; _i < 16; x = ++_i) {
        column = [];
        row = desc.cols[x];
        for (y = _j = 0; _j < 11; y = ++_j) {
          tileId = row[y];
          tileKlass = this.idToTile(tileId);
          tile = tileKlass.create(x, y);
          this.addChild(tile);
          column.push(tile);
        }
        this.tiles.push(column);
      }
      _ref = desc.items;
      for (_k = 0, _len = _ref.length; _k < _len; _k++) {
        item = _ref[_k];
        x = item.x;
        y = item.y;
        type = item.type;
        tile = this.tiles[x][y].addItem(type, item);
      }
      this.inventory = desc.inventory;
      return this.nextLevel = desc.nextLevel;
    },
    playerCanMoveForward: function(player) {
      var newPosition, nextTile;
      newPosition = player.getNextTilePosition();
      nextTile = this.tiles[newPosition.x][newPosition.y];
      return nextTile.canEnter();
    },
    playerMoveCompleted: function(player) {
      var currentPosition, currentTile;
      currentPosition = player.getTilePosition();
      currentTile = this.tiles[currentPosition.x][currentPosition.y];
      return currentTile.playerEntered(player);
    },
    addItem: function(x, y, type, item) {
      var tile;
      return tile = this.tiles[x][y].addItem(type, item);
    },
    idToTile: function(id) {
      switch (id) {
        case Map.ids.empty:
          return EmptyTile;
        case Map.ids.wall:
          return WallTile;
      }
    },
    getNextLevel: function() {
      return this.nextLevel;
    },
    getInventory: function() {
      return this.inventory;
    }
  });

  this.Map.ids = {
    empty: 0,
    wall: 1
  };

  this.Map.create = function(mapJson) {
    var map;
    map = new Map();
    map.init();
    return map;
  };

}).call(this);
