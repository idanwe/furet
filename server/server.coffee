Hapi = require "hapi"

defaults =
  port: process.env.PORT ? 8000

server = new Hapi.Server +defaults.port, "0.0.0.0"

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
  console.log "server running on port #{server.info.port}"
