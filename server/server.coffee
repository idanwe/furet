Hapi = require "hapi"

defaults =
  port: process.env.PORT ? 8000

server = new Hapi.Server "0.0.0.0", +defaults.port

server.route
  method: "GET",
  path: "/{path*}",
  handler:
    directory:
      path: "./app",
      listing: false,
      index: true

server.route
  method: "GET"
  path: "/users"
  handler: ->
    @reply "its work on heroku, fuck bower"

server.start ->
  console.log "server.info.uri", server.info.uri
  console.log "process.env.HOST", process.env.HOST
  server.info.uri = if process.env.HOST? then "http://#{process.env.HOST}:process.env.PORT" else server.info.uri
  console.log "server running on port #{server.info.port}"
  console.log "Server started at #{server.info.uri}"
