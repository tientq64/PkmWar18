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

	w = canvasEl.width = img.width
	h = canvasEl.height = img.height

	g.clearRect 0, 0, w, h
	g.drawImage img, 0, 0, w, h / 2, 0, h / 2, w, h / 2
	g.drawImage img, 0, h / 2, w, h / 2, 0, 0, w, h / 2

	saveImg file.name

	setTimeout (=> execFile files, i + 1 if files[i + 1]; return), 200
	console.log i

fileEl.onchange = (event) ->
	execFile event.target.files, 0
	return
