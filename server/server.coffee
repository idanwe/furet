Hapi = require "hapi"
TeamsFetcher = require("./teamsFetcher")

defaults =
  port: +process.env.PORT or 8000

server = new Hapi.Server defaults.port, "0.0.0.0"

MINUTE = 60 * 1000
HOUR = 60 * MINUTE

# little note about cache:
# when using Hapi cache, one must use create the cache on a function with callback:
# (err, result) ->
# and not on the handler itself of type:
# (request, reply) ->
server.method 'getTeams', TeamsFetcher.getTeams,
 cache:
    # the cahce cleans after one hour
    expiresIn: 1 * HOUR
    # one can get a new answer after 30min but it must return under 500ms, otherwise the cached answer is returned
    staleIn: 30 * MINUTE
    staleTimeout: 500
  generateKey: (endpoint, params) ->
    endpoint + JSON.stringify(params)

server.route([
  {
    method: "GET",
    path: "/teams",
    config:
      handler: (request, reply) ->
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
