Hapi = require "hapi"
TeamsFetcher = require("./teamsFetcher")

defaults =
  port: +process.env.PORT or 8000

server = new Hapi.Server defaults.port, "0.0.0.0"

MINUTE = 60 * 1000
HOUR = 60 * MINUTE

server.method 'getTeams', TeamsFetcher.getTeams,
 cache:
    expiresIn: 1 * HOUR
    staleIn: 30 * MINUTE
    staleTimeout: 500
  generateKey: (endpoint, params)->
    endpoint + JSON.stringify(params)

server.route([
  {
    method: "GET",
    path: "/teams",
    config:
      handler: (request, reply)->
        server.methods.getTeams (err, result) ->
          reply if err then err else result
  },
  {
    method: "GET",
    path: "/{path*}",
    handler:
      directory:
        path: "./app",
        listing: false,
        index: true
  }
])

server.start ->
  server.info.uri = if process.env.HOST? then "http://#{process.env.HOST}:#{process.env.PORT}" else server.info.uri
  console.log "Server started at #{server.info.uri}"
