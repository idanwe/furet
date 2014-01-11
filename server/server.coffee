Hapi = require "hapi"

defaults =
  port: +process.env.PORT or 8000

server = new Hapi.Server defaults.port, "0.0.0.0"

server.route
  method: "GET",
  path: "/{path*}",
  handler:
    directory:
      path: "./app",
      listing: false,
      index: true

server.start ->
  server.info.uri = if process.env.HOST? then "http://#{process.env.HOST}:#{process.env.PORT}" else server.info.uri
  console.log "Server started at #{server.info.uri}"
