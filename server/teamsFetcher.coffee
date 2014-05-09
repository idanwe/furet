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
    numberOfTeams: 4},
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

exports.getTeams = (done) ->
  startTime = new Date()
  teams = []
  console.log "getTeams started #{new Date()}"
  Async.each leagues, (league, next) ->
    console.log "Fetching #{league.numberOfTeams} teams for #{league.leagueName} from #{league.url}"
    html = ""
    httpRequest = Http.get league.url, (response) ->
      response.on "data", (chunk) ->
        html += chunk
      response.on "end", ->
        return done(new Hapi.error.internal("Error getting webpage from #{league.url}"), null) if html is ""
        for i in [0...league.numberOfTeams]
          teamParentElement = $(html).find("tr td.rnk:eq(#{i})").parent()
          teamName = teamParentElement.children("td.team").text()
          teamFullID = teamParentElement.attr('data-filter')
          teamID = teamFullID.split('_')[1]
          teams.push
            teamName: teamName
            teamID: teamID
            image_src: "http://www.fifa.com/mm/teams/#{teamID}/#{teamID}x4.png"
         next()
    httpRequest.on 'error', (err) ->
      console.log("Got error: " + err.message)
      return done(new Hapi.error.internal(err), null)
  , (err) ->
    return done(new Hapi.error.internal(err), null) if err
    console.log "getTeams finished in #{new Date() - startTime}ms"
    console.log "teams selected: #{JSON.stringify(teams)}"
    done(null,teams)


