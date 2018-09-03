fs = require "fs"
coffee = (require "./libs/coffee.min").CoffeeScript
uglify = require "./libs/uglify.min"

files = [
	"store"
	"boot"
	"load"
	"menu"
	"play"
	"game"
	"Pkm"
]

code = ""

for file from files
	code += fs.readFileSync "scripts/#{file}.coffee", "utf-8"

code = coffee.compile code, bare: yes
code = (uglify.minify code).code

fs.writeFileSync "index.js", code
