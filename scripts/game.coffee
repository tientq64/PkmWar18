game = new Phaser.Game
	width: window.innerWidth
	height: window.innerHeight
	renderer: Phaser.AUTO
	antialias: no
	scaleMode: Phaser.ScaleManager.SHOW_ALL

game.state.add "boot", bootState, yes
game.state.add "load", loadState
game.state.add "play", playState
