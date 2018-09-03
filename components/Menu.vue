<template lang="pug">
	.menu
		.list
			.item(
				v-for="pkd in Pkd"
				:style="[styleItem(pkd), styleItemBg(pkd)]"
				@mousedown.left="sel = pkd"
				@mouseup.left="$el.hidden = true"
			)
		.w3-flex.w3-margin-top
			button.w3-button.w3-light-gray(
				@click="clickStart"
			) START
</template>

<script lang="coffee">
	module.exports =
		props: ["clickStart"]

		data: ->
			sel: selPkd

		methods:
			styleItem: (pkd) ->
				if @sel is pkd
					outline: "solid 2px #ff0"
					backgroundColor: "#ff06"

			styleItemBg: (pkd) ->
				i = pkd.no - 1
				backgroundPositionX: "-#{i % 10 * 32}px"
				backgroundPositionY: "-#{32 * Math.floor i / 10}px"

			clickStart: ->
				game.state.start "play", no
				@$destroy()
				return

		watch:
			sel: (val) ->
				window.selPkd = val
				return
</script>

<style lang="stylus" scoped>
	.menu
		width 100%
		height 100%
		background #fff8

	.list
		height 80%
		margin 60px 120px 0
		text-align center
		overflow-y overlay

		&::-webkit-scrollbar
			-webkit-appearance none

	.item
		width 32px
		height 32px
		background url("/assets/pkdIcon.png") no-repeat
		display inline-block
		outline-offset -2px
		zoom 2
</style>
