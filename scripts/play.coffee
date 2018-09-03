playState =
	create: ->
		pkms.callAll "randomWalk"
		return

	update: ->
		game.physics.arcade.collide pkms
		pkms.sort "y", Phaser.Group.SORT_ASCENDING
		return
