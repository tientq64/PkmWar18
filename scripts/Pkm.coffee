class Pkm extends Phaser.Sprite
	constructor: (game, pkdName, x, y, d, @team) ->
		super game, x, y, pkdName

		@pkd = Pkd[pkdName]
		@target = []

		@scale.set 3
		@anchor.set .5, .75
		@smoothed = no

		@animations.add "walk-1", [0, 1], 8, yes
		@animations.add "walk-2", [2, 3], 8, yes
		@animations.add "walk-3", [4, 5], 8, yes
		@animations.add "walk-4", [6, 7], 8, yes

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

		@grpMove = game.make.group @

	setD: (d) ->
		@d = d
		@frame = (@d - 1) * 2
		@body.angle = [, Math.PI, 0, -Phaser.Math.HALF_PI, Phaser.Math.HALF_PI][@d]
		return

	walk: (dist, d) ->
		@setD d if d
		@body.moveTo dist * 500 / @pkd.stats.spe, dist
		@animations.play "walk-#{@d}"
		return

	randomWalk: ->
		unless @body.isMoving
			@walk Phaser.Math.between(10, 300), Phaser.Math.between(1, 4)
		return

	collideAlly: (ally) ->
		@body.stopMovement()
		return

	collideEnemy: (enemy) ->
		@target = enemy
		@fight()
		return

	fight: ->
		return

	update: ->
		return
