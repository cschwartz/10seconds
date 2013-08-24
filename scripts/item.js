// Generated by CoffeeScript 1.6.3
(function() {
  this.ChangeDirection = cc.Sprite.extend({
    init: function(description) {
      this._super();
      this.initWithFile(ChangeDirection.icon);
      this.setPosition(cc.p(32, 32));
      return this.setRotation(description.newDirection);
    },
    interact: function(player, tile) {
      return player.rotate(this.getRotation(), tile);
    }
  });

  ChangeDirection.icon = change_direction;

  ChangeDirection.createIcon = function(description) {
    var icon;
    icon = cc.Sprite.create(description.type.icon);
    icon.setRotation(description.newDirection);
    icon.setPosition(cc.p(32, 32));
    icon.setScale(0.8);
    return icon;
  };

  ChangeDirection.create = function(description) {
    var item;
    item = new ChangeDirection();
    item.init(description);
    return item;
  };

}).call(this);
