deasync = require 'deasync'
child_process = require 'child_process'
exec = deasync child_process.exec

getClipboard = ()->
  exec 'xclip -o -selection clipboard'

monitorClipboard = (callback)->
  initial = getClipboard()
  setInterval(() ->
    if getClipboard()!=initial
      initial=getClipboard()
      callback(initial)
  ,
  50
  )

express = require('express')
stylus = require('stylus')
nib = require('nib')
morgan = require 'morgan'
app = express()
hyper_links = []
texts = []

monitorClipboard((data) ->
  if(data.startsWith("http://") or data.startsWith("https://"))
    hyper_links.unshift(data)
  else
    texts.unshift(data)

)
compile = (str, path) ->
  stylus(str).set('filename', path).use nib()

app.set 'views', __dirname + '/views'
app.set 'view engine', 'jade'
app.use morgan('dev')
app.use stylus.middleware(
  src: __dirname + '/public'
  compile: compile)
app.use express.static(__dirname + '/public')

app.get '/', (req, res) ->
  res.render 'index', title: 'iostreamer', links:hyper_links, text: texts
app.listen 3000
