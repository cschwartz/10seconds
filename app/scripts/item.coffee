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

@Goal = cc.Sprite.extend
  init: (description) ->
    @_super
    @initWithFile(Goal.icon)
    @setPosition(cc.p(32, 32))

  interact: (player, tile) ->
    player.levelComplete()

Goal.icon = goal

Goal.create = (description) ->
  goal = new Goal()
  goal.init(description)
  goal
