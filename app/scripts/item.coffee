@Item = cc.Sprite.extend
  init: (description, map, tile) ->
    @_super()
    @initWithFile(description.type.icon)
    @setPosition(cc.p(32, 32))
    @map = map
    @tile = tile

  getTag: ->
    undefined

@ChangeDirection = Item.extend
  init: (description, map, tile) ->
    @_super(description, map, tile)
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

ChangeDirection.create = (description, map, tile) ->
  item = new ChangeDirection()
  item.init(description, map, tile)
  item

@Goal = Item.extend
  init: (description, map, tile) ->
    @_super(description, map, tile)
    @setScale(0.9)
    @getTexture().generateMipmap()

  interact: (player, tile) ->
    player.levelComplete()

Goal.icon = goal

Goal.create = (description, map, tile) ->
  goal = new Goal()
  goal.init(description, map, tile)
  goal

@SpeedUp = Item.extend
  init: (description, map, tile) ->
    @_super(description, map, tile)
    @setRotation(description.direction)

  interact: (player, tile) ->
    player.speedUp(tile)

SpeedUp.icon = speedUp

SpeedUp.create = (description, map, tile) ->
  speedUp = new SpeedUp()
  speedUp.init(description, map, tile)
  speedUp

@PortalA = Item.extend
  init: (description, map, tile) ->
    @_super(description, map, tile)
    @destination = cc.p(description.destinationX, description.destinationY)
    @oppositePortal = @map.getItemByTag(PortalB.tag)
    @closedPortal = cc.Sprite.create(portal_a_closed)
    @closedPortal.setPosition(cc.p(32, 32))
    @closedPortal.setOpacity(127)
    @addChild(@closedPortal, -1)
    if @oppositePortal
      @closedPortal.setVisible(false)
      @oppositePortal.otherPortalSpawned(@)

  getTile: ->
    @tile

  otherPortalSpawned: (otherPortal) ->
    @closedPortal.setVisible(false)
    @oppositePortal = otherPortal
    @tile.reprocessItems()

  interact: (player, tile) ->
    if @oppositePortal
      player.teleport(@oppositePortal.getTile().getPosition(), tile)

  getTag: ->
    PortalA.tag

PortalA.icon = portal_a
PortalA.tag = "portal_a"

PortalA.create = (description, map, tile) ->
  portal = new PortalA()
  portal.init(description, map, tile)
  portal

PortalA.createIcon = (description) ->
  icon = cc.Sprite.create(description.type.icon)
  icon.setPosition(cc.p(32, 32))
  icon.setScale(0.8)
  icon

@PortalB = Item.extend
  init: (description, map, tile) ->
    @_super(description, map, tile)
    @destination = cc.p(description.destinationX, description.destinationY)
    @closedPortal = cc.Sprite.create(portal_b_closed)
    @closedPortal.setPosition(cc.p(32, 32))
    @closedPortal.setOpacity(127)
    @addChild(@closedPortal, -1)
    @oppositePortal = @map.getItemByTag(PortalA.tag)
    if @oppositePortal
      @closedPortal.setVisible(false)
      @oppositePortal.otherPortalSpawned(@)

  otherPortalSpawned: (otherPortal) ->
    @closedPortal.setVisible(false)
    @oppositePortal = otherPortal

  getTile: ->
    @tile

  getTag: ->
    PortalB.tag

  interact: (player, tile) ->
    if @oppositePortal
      player.teleport(@oppositePortal.getTile().getPosition(), tile)

PortalB.icon = portal_b
PortalB.tag = "portal_b"

PortalB.create = (description, map, tile) ->
  portal = new PortalB()
  portal.init(description, map, tile)
  portal

PortalB.createIcon = (description) ->
  icon = cc.Sprite.create(description.type.icon)
  icon.setPosition(cc.p(32, 32))
  icon.setScale(0.8)
  icon

