loadState =
	preload: ->
		game.load.image "pkdIcon", "assets/pkdIcon.png"

		for k, pkd of Pkd
			size = if pkd.largeSprite then 64 else 32
			game.load.spritesheet k, "assets/pkd/#{pkd.no}.png", size, size, 8
		return

	create: ->
		game.state.start "menu"
		return
