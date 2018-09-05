fileEl = document.createElement "input"
document.body.appendChild fileEl
fileEl.type = "file"
fileEl.multiple = yes

canvasEl = document.createElement "canvas"
document.body.appendChild canvasEl

g = canvasEl.getContext "2d"
g.imageSmoothingEnabled = no

readImg = (file) ->
	fileReader = new FileReader

	new Promise (resolve) =>
		fileReader.onload = =>
			src = fileReader.result

			img = new Image
			img.src = src

			img.onload = =>
				resolve img
				return
			return

		fileReader.readAsDataURL file
		return

saveImg = (fileName) ->
	aEl = document.createElement "a"
	aEl.href = canvasEl.toDataURL()
	aEl.download = fileName
	aEl.click()
	return

execFile = (files, i) ->
	file = files[i]
	img = await readImg file

	if img.height is 96 or img.height is 192
		w = canvasEl.width = img.width
		h = canvasEl.height = img.height / 3 * 4

		g.clearRect 0, 0, w, h
		g.drawImage img, 0, 0

		g.save()
		g.translate w, 0
		g.scale -1, 1
		g.drawImage img, 0, h / 2, w, h / 4, 0, img.height, w, h / 4
		g.restore()

		saveImg file.name

		setTimeout (=> execFile files, i + 1 if files[i + 1]; return), 500
	else
		execFile files, i + 1 if files[i + 1]

	console.log i

fileEl.onchange = (event) ->
	execFile event.target.files, 0
	return
