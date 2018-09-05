fs = require "fs"
coffee = (require "./libs/coffee.min").CoffeeScript
uglify = require "./libs/uglify.min"

files = [
	"store"
	"boot"
	"load"
	"play"
	"game"
	"Pkm"
]

code = ""

for file from files
	code += fs.readFileSync "scripts/#{file}.coffee", "utf-8"

code = coffee.compile code, bare: yes
code = uglify.minify code,
	ecma: 8
	ie8: no
	toplevel: no
	compress:
		dead_code: yes
		unused: yes
		unsafe_arrows: yes
		unsafe_comps: no
		unsafe_Function: yes
		unsafe_math: yes
		unsafe_methods: yes
		unsafe_proto: yes
		unsafe_regexp: no
.code

fs.writeFileSync "index.js", code
