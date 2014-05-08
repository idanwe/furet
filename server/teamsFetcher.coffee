Jsdom = require "jsdom"
$ = require("jquery")(Jsdom.jsdom().createWindow())
Http = require "http"
Async = require "async"
Hapi = require "hapi"

Http.globalAgent.maxSockets = 10;

leagues = [
    {leagueName: "Spain",
    url: "http://www.fifa.com/world-match-centre/nationalleagues/nationalleague=spain-liga-2000000037/standings/index.html",
    numberOfTeams: 3},
    {leagueName: "England",
    url: "http://www.fifa.com/world-match-centre/nationalleagues/nationalleague=england-premier-league-2000000000/standings/index.html",
    numberOfTeams: 3},
    {leagueName: "Germany",
    url: "http://www.fifa.com/world-match-centre/nationalleagues/nationalleague=germany-bundesliga-2000000019/standings/index.html",
    numberOfTeams: 3},
    {leagueName: "Italy",
    url: "http://www.fifa.com/world-match-centre/nationalleagues/nationalleague=italy-serie-a-2000000026/standings/index.html",
    numberOfTeams: 3},
    {leagueName: "Portugal",
    url: "http://www.fifa.com/world-match-centre/nationalleagues/nationalleague=portugal-liga-2000000033/standings/index.html",
    numberOfTeams: 2},
    {leagueName: "France",
    url: "http://www.fifa.com/world-match-centre/nationalleagues/nationalleague=france-ligue-1-2000000018/standings/index.html",
    numberOfTeams: 2},
    {leagueName: "Netherlands",
    url: "http://www.fifa.com/world-match-centre/nationalleagues/nationalleague=netherlands-eredivisie-2000000022/standings/index.html",
    numberOfTeams: 1}
  ]

exports.getTeams = (request, reply) ->
  teams = []
  console.log "getTeams started #{new Date()}"
  Async.each leagues, (league, next) ->
    console.log "Fetching #{league.numberOfTeams} teams for #{league.leagueName} from #{league.url}"
    html = ""
    httpRequest = Http.get league.url, (response) ->
      response.on "data", (chunk) ->
        html += chunk
      response.on "end", ->
        return reply(new Hapi.error.internal("Error getting webpage from #{league.url}")) if html is ""
        for i in [0...league.numberOfTeams]
          team = $(html).find("tr td.rnk:eq(#{i})").parent().children("td.team").text()
          teams.push team
         next()
    httpRequest.on 'error', (err) ->
      console.log("Got error: " + err.message)
      return reply(new Hapi.error.internal(err))
  , (err) ->
    return reply(new Hapi.error.internal(err)) if err
    reply(teams)


