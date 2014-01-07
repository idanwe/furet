Hapi = require "hapi"

defaults =
  port: process.env.PORT ? 8000

server = new Hapi.Server "localhost", parseInt(defaults.port)

server.route
  method: "GET",
  path: "/{path*}",
  handler:
    directory:
      path: "./app",
      listing: false,
      index: true

server.start ->
  console.log "server running on port #{server.info.port}"
