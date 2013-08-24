// Generated by CoffeeScript 1.6.3
(function() {
  this.ChangeDirection = cc.Sprite.extend({
    init: function(description) {
      this._super();
      this.initWithFile(change_direction);
      this.setPosition(cc.p(32, 32));
      return this.setRotation(description.newDirection);
    },
    interact: function(player, tile) {
      return player.rotate(this.getRotation(), tile);
    }
  });

  ChangeDirection.create = function(description) {
    var item;
    item = new ChangeDirection();
    item.init(description);
    return item;
  };

}).call(this);