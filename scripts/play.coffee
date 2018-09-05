playState =
	create: ->
		selPkd = Pkd.bulbasaur

		field = game.add.graphics()

		field.beginFill 0xf44336
		field.drawRect 0, 0, game.world.centerX, game.height
		field.beginFill 0x009688
		field.drawRect game.world.centerX, 0, game.world.centerX, game.height

		field.beginFill 0xcccccc
		field.drawRect game.world.centerX - 10, 0, 20, game.height
		field.drawCircle game.world.centerX, game.world.centerY, 192
		field.beginFill 0xbbbbbb
		field.drawCircle game.world.centerX, game.world.centerY, 160

		field.endFill()
		field.inputEnabled = yes

		field.events.onInputDown.add (field, pt) ->
			team = +(pt.positionDown.x < game.world.centerX)

			pkm = new Pkm(
				game
				selPkd.name
				pt.positionDown.x
				pt.positionDown.y
				Phaser[["LEFT", "RIGHT"][team]]
				team
			)
			pkms.add pkm

			pkm.randomWalk() if isStarted
			return

		keySpace = game.input.keyboard.addKey Phaser.Keyboard.SPACEBAR
		keySpace.onDown.add ->
			vmPlay.$children[0].toggle()
			return

		pkms = game.add.group()

		vmPlay = new Vue
			template: "<Play/>"
			components: ["url:components/Play.vue"]
		return

	update: ->
		game.physics.arcade.collide pkms
		pkms.sort "y", Phaser.Group.SORT_ASCENDING
		return
