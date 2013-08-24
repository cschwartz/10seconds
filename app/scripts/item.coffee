@ChangeDirection = cc.Sprite.extend
  init: (description) ->
    @_super()
    @initWithFile(ChangeDirection.icon)
    @setPosition(cc.p(32, 32))
    @setRotation(description.newDirection)

  interact: (player, tile) ->
    player.rotate(@getRotation(), tile)

ChangeDirection.icon = change_direction

ChangeDirection.createIcon = (description) ->
  icon = cc.Sprite.create(description.type.icon)
  icon.setRotation(description.newDirection)
  icon.setPosition(cc.p(32, 32))
  icon.setScale(0.8)
  icon


ChangeDirection.create = (description) ->
  item = new ChangeDirection()
  item.init(description)
  item
