deasync = require 'deasync'
child_process = require 'child_process'
exec = deasync child_process.exec

getClipboard = ()->
  try
    exec 'xclip -o -selection clipboard'
  catch error
    null

monitorClipboard = (callback)->
  initial = getClipboard()
  setInterval(() ->
    if getClipboard()!=initial
      initial=getClipboard()
      if initial?
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
  res.render 'index'
app.get '/links', (req,res) ->
  res.send hyper_links
app.get '/text', (req,res) ->
  res.send texts

server = app.listen 8080
io= require('socket.io')(server)

monitorClipboard((data) ->
  if(data.startsWith("http://") or data.startsWith("https://"))
    hyper_links.unshift({link:data})
    io.sockets.emit 'link',{link:data}
  else if(data.length > 0)
    texts.unshift({text:data})
    io.sockets.emit 'text',{text:data}
)

stdin = process.openStdin()
stdin.addListener 'data', (d) -> 
  data = d.toString().trim()
  switch data
   when 'clear'
    io.sockets.emit 'reset_all',{data:'reset_all'}
    hyper_links=[]
    texts=[]
    
