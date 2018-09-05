loadState =
	preload: ->
		game.load.image "pkdIcon", "assets/pkdIcon.png"
		game.load.image "none", "assets/none.png"
		game.load.bitmapFont "fipps", "fonts/fipps.png", "fonts/fipps.xml"

		for v from @assets.move
			v = [v, 32, 32] if typeof v is "string"
			game.load.spritesheet v, "assets/move/#{v[0]}.png", v[1], v[2]

		for k, pkd of Pkd
			size = if pkd.largeSprite then 64 else 32
			game.load.spritesheet k, "assets/pkd/#{pkd.no}.png", size, size, 8
		return

	create: ->
		game.state.start "play"
		return

	assets:
		move: [
			"acid"
			"ball"
			"ball-1"
			"bell"
			"bone"
			"bone-boomerang"
			"claw"
			"cut"
			"dragon-pulse"
			"evil"
			"explosive"
			"explosive-1"
			"eye"
			"fairy"
			"heart"
			"hit"
			"ice-break"
			"meteor"
			"rock"
			"scratch"
			"shadow-ball"
			"soap-bubble"
			"soul"
			"spider-web"
			"spin"
			"spin-1"
			"sting"
			"stone"
			["tornado", 32, 64]
			"toxic"
		]
