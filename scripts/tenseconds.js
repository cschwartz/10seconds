// Generated by CoffeeScript 1.6.3
(function() {
  this.InventoryItem = cc.MenuItemToggle.extend({
    init: function(game, itemBar, description) {
      var button_disabled_item, button_pressed_item, button_unpressed_item;
      this.game = game;
      this.itemBar = itemBar;
      this.description = description;
      button_unpressed_item = cc.MenuItemSprite.create(cc.Sprite.create(button_unpressed));
      button_pressed_item = cc.MenuItemSprite.create(cc.Sprite.create(button_pressed));
      button_disabled_item = cc.MenuItemSprite.create(cc.Sprite.create(button_disabled));
      this.initWithItems([
        button_unpressed_item, button_pressed_item, button_disabled_item, (function() {
          return this.buttonPressed();
        }), this
      ]);
      if (!description) {
        this.setSelectedIndex(2);
        return this.setEnabled(false);
      } else {
        this.icon = description.type.createIcon(description);
        this.addChild(this.icon, 1);
        return true;
      }
    },
    useAtLocation: function(x, y) {
      this.game.addItem(x, y, this.description.type, this.description);
      this.description.amount--;
      if (this.description.amount === 0) {
        this.setEnabled(false);
        this.setSelectedIndex(2);
        this.icon.setOpacity(127);
        return this.game.setCurrentInventory(void 0);
      }
    },
    disable: function() {
      if (this.description.amount !== 0) {
        return this.setSelectedIndex(0);
      }
    },
    buttonPressed: function() {
      if (this.getSelectedIndex() === 1) {
        this.itemBar.selected(this);
        return this.game.setCurrentInventory(this);
      } else {
        this.itemBar.selected(void 0);
        this.game.setCurrentInventory(void 0);
        return this.setSelectedIndex(0);
      }
    }
  });

  InventoryItem.create = function(game, menu, description) {
    var item;
    item = new InventoryItem();
    item.init(game, menu, description);
    return item;
  };

  this.ItemBar = cc.Node.extend({
    init: function(game, inventory) {
      var i, item, screenSize, _i;
      this._super();
      this.game = game;
      screenSize = cc.Director.getInstance().getWinSize();
      this.menu = cc.Menu.create();
      this.addChild(this.menu);
      this.menu.setPosition(screenSize.width / 2, screenSize.height - 32);
      for (i = _i = 0; _i < 16; i = ++_i) {
        item = InventoryItem.create(game, this, inventory[i]);
        this.menu.addChild(item);
      }
      return this.menu.alignItemsHorizontallyWithPadding(0);
    },
    selected: function(item) {
      if (this.selectedItem) {
        this.selectedItem.disable();
      }
      return this.selectedItem = item;
    }
  });

  ItemBar.create = function(game, inventory) {
    var itemBar;
    itemBar = new ItemBar();
    itemBar.init(game, inventory);
    return itemBar;
  };

  this.TimeGauge = cc.Node.extend({
    init: function(game) {
      this._super();
      this.game = game;
      this.totalTime = 10;
      this.currentTime = this.totalTime;
      this.drawing = new cc.DrawingPrimitiveWebGL();
      return this.screenSize = cc.Director.getInstance().getWinSize();
    },
    update: function(dt) {
      this.currentTime -= dt;
      if (this.currentTime < 0) {
        this.currentTime = 0;
        return this.game.timeEllapsed();
      }
    },
    draw: function() {
      var colorBackground, colorEnergy, i, _i;
      colorBackground = new cc.c4f(52 / 255, 73 / 255, 94 / 255, 255 / 255);
      colorEnergy = new cc.c4f(52 / 255, 152 / 255, 219 / 255, 255 / 255);
      this.drawing.drawSolidRect(cc.p(16, 16), cc.p(this.screenSize.width - 16, 48), colorBackground);
      this.drawing.drawSolidRect(cc.p(20, 20), cc.p(20 + (this.currentTime / this.totalTime) * (this.screenSize.width - 40), 44), colorEnergy);
      for (i = _i = 1; _i < 10; i = ++_i) {
        this.drawing.drawSolidRect(cc.p(16 + (this.screenSize.width - 32) * i / 10 - 2, 20), cc.p(16 + (this.screenSize.width - 32) * i / 10 + 2, 44), colorBackground);
      }
      return true;
    }
  });

  TimeGauge.create = function(game) {
    var timeGauge;
    timeGauge = new TimeGauge(game);
    timeGauge.init(game);
    return timeGauge;
  };

  this.GameLayer = cc.Layer.extend({
    init: function() {
      this._super();
      this.map = MapOne.create();
      this.addChild(this.map);
      this.player = Player.create(this.map, 1, 1);
      this.addChild(this.player);
      this.timeGauge = TimeGauge.create(this);
      this.addChild(this.timeGauge);
      this.itemBar = ItemBar.create(this, this.map.getInventory());
      this.addChild(this.itemBar);
      this.schedule(this.update);
      this.isRunning = false;
      this.setTouchEnabled(true);
      return true;
    },
    update: function(dt) {
      if (!this.isRunning) {
        this.isRunning = true;
        this.player.moveForward();
      }
      return this.timeGauge.update(dt);
    },
    timeEllapsed: function() {
      return this.player.stopAllActions();
    },
    createLevel: function(levelName) {
      return true;
    },
    menuCloseCallback: function(sender) {
      return true;
    },
    addItem: function(x, y, type, description) {
      return this.map.addItem(x, y, type, description);
    },
    setCurrentInventory: function(inventory) {
      return this.currentInventory = inventory;
    },
    onTouchesBegan: function(touches, events) {
      var tap, touch;
      if (touches && this.currentInventory) {
        touch = touches[0];
        tap = touch.getLocation();
        this.currentInventory.useAtLocation(Math.floor(tap.x / 64), Math.floor(tap.y / 64));
      }
      return true;
    },
    onTouchesMoved: function(touches, event) {
      return true;
    },
    onTouchesEnded: function(touches, event) {
      return true;
    },
    onTouchesCancelled: function(touches, event) {
      return true;
    }
  });

  this.TenSecondsScene = cc.Scene.extend({
    onEnter: function() {
      var layer;
      this._super();
      layer = new GameLayer();
      layer.init();
      return this.addChild(layer);
    }
  });

}).call(this);
