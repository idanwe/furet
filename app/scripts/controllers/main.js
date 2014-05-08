'use strict';

angular.module('furetApp')
  .controller('MainCtrl', function ($scope, $timeout, $http) {
    $scope.gamePicked = false;
    $scope.team1 = '';
    $scope.team2 = '';

    $http({method: 'GET', url: "/teams"}).
    success(function(data, status, headers, config) {
      console.log(data)
      $scope.teams = data
    })

    var random = function(num) {
      return Math.floor(Math.random() * num);
    };

    $scope.pickTeams = function() {
      var teams = angular.copy($scope.teams),
          team1 = random(teams.length),
          team2 = random(teams.length - 1);

      $scope.team1 = teams.splice(team1, 1)[0];
      $scope.team2 = teams.splice(team2, 1)[0];
      $scope.gamePicked = true;
    };
  });
