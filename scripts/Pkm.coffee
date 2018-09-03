class Pkm extends Phaser.Sprite
	constructor: (game, pkdName, x, y, d, @team) ->
		super game, x, y, pkdName

		@pkd = Pkd[pkdName]

		@scale.set 3
		@anchor.set .5, .75
		@smoothed = no

		@animations.add "walk-0", [0, 1], 8, yes
		@animations.add "walk-1", [6, 7], 8, yes
		@animations.add "walk-2", [2, 3], 8, yes
		@animations.add "walk-3", [4, 5], 8, yes

		@game.physics.arcade.enableBody @

		r = @width / @scale.x / 4

		@body.setCircle r, r, r * 2
		@body.collideWorldBounds = yes
		@body.allowGravity = no
		@body.mass = 1 + @pkd.weight / 1000

		@setD d

		@body.onMoveComplete.add =>
			@randomWalk()
			return

		@body.onWorldBounds = new Phaser.Signal
		@body.onWorldBounds.add =>
			@body.stopMovement()
			return

		@body.onCollide = new Phaser.Signal
		@body.onCollide.add (pkm) =>
			if @team is pkm.team
				@collideAlly pkm
			else
				@collideEnemy pkm
			return

	setD: (d) ->
		if d?
			@d = d %% 4
			dMap = @constructor.dMap[@d]

			@frame = dMap.frame
			@body.angle = dMap.angle
		return

	walk: (dist, d) ->
		@setD d
		dMap = @constructor.dMap[@d]

		@animations.play "walk-#{@d}"
		@body.moveTo dist * 5 * 100 / @pkd.stats.spe, dist
		return

	randomWalk: ->
		unless @body.isMoving
			@walk @game.math.between(10, 300), @game.math.between(0, 3)
		return

	collideAlly: (ally) ->
		@body.stopMovement()
		return

	collideEnemy: (enemy) ->
		return

	@dMap = [{
		frame: 0
		angle: -Math.PI / 2
		delta: x: 0, y: -1
	}, {
		frame: 6
		angle: 0
		delta: x: 1, y: 0
	}, {
		frame: 2
		angle: Math.PI / 2
		delta: x: 0, y: 1
	}, {
		frame: 4
		angle: Math.PI
		delta: x: -1, y: 0
	}]
