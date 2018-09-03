menuState =
	create: ->
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

		field.events.onInputUp.add (field, pt) ->
			pkm = new Pkm(
				game
				selPkd.name
				pt.positionUp.x
				pt.positionUp.y
				3
				game.math.between 0, 1
			)
			pkms.add pkm
			return

		text = game.add.text game.world.centerX, 24, "Pokémon War",
			font: "bold 16pt fantasy",
			fill: "#fff"
			stroke: "#111"
			strokeThickness: 6

		text.anchor.set .5
		text.alpha = .2

		keySpace = game.input.keyboard.addKey Phaser.Keyboard.SPACEBAR
		keySpace.onDown.add ->
			vmMenu.$el.hidden = !vmMenu.$el.hidden
			return

		selPkd = Pkd.bulbasaur

		pkms = game.add.group()

		vmMenu = new Vue
			template: "<Menu />"
			components: ["url:components/Menu.vue"]
		return

	update: ->
		game.physics.arcade.collide pkms
		pkms.sort "y", Phaser.Group.SORT_ASCENDING
		return
