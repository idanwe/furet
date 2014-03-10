'use strict';

angular.module('furetApp')
  .controller('MainCtrl', function ($scope, $timeout) {
    $scope.gamePicked = false;
    $scope.team1 = '';
    $scope.team2 = '';

    $scope.teams = [
      // 3 Spain
      'Real Madrid',
      'Atletico Madrid',
      'FC Barcelona',

      // 3 England
      'Chelsea',
      'Liverpool',
      'Arsenal',

      'Manchester City',

      // 3 Germany
      'FC Bayern Munich',
      'Bayer Leverkusen',
      'Borussia Dortmund',

      // 2 Italy
      'Juventus',
      'A.S. Rome',

      'S.S.C. Napoli',

      // 2 Portugal
      'Benefica',
      'Sporting Lisbon',

      // 2 France
      'PSG',
      'Monaco',

      // 1 Netherlands
      'Ajax',

      // 1 Russia
      'Zenit',

      // 1 Ukraine
      'Shakhtar Donetsk',

      // 1 Belgium
      'Standard Liege',

      // 1 Turkey
      'Fenerbahce',

      // 1 Greece
      'Olympiakos'
    ];

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
