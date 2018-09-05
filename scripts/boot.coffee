bootState =
	preload: ->
		game.load.json "Type", "models/Type.json"
		game.load.json "Stat", "models/Stat.json"
		game.load.json "Move", "models/Move.json"
		game.load.json "Pkd", "models/Pkd.json"
		return

	create: ->
		Type = game.cache.getJSON "Type"
		Stat = game.cache.getJSON "Stat"
		Move = game.cache.getJSON "Move"
		Pkd = game.cache.getJSON "Pkd"

		for k, pkd of Pkd
			pkd.moves = pkd.moves
				.filter (move) => @movesEnabled.includes move
				.map (move) => Move[move]

		Vue.mixin
			created: ->
				el = document.createElement "div"
				document.body.appendChild el
				@$mount el
				return

			destroyed: ->
				@$el.remove()
				return

		game.physics.startSystem Phaser.Physics.ARCADE

		game.state.start "load"
		return

	movesEnabled: [
		"tackle"
	]
