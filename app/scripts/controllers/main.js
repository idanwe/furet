'use strict';

angular.module('FIFA14App')
  .controller('MainCtrl', function ($scope) {
    $scope.gameStarted = false;
    $scope.team1 = '';
    $scope.team2 = '';

    var allTeams = [
      'Real Madrid',
      'Atletico Madrid',
      'FC Barcelona',

      'Arsenal',
      'Chelsea',
      'Manchester United',
      'Manchester City',

      'A.C. Milan',
      'Juventus',
      'Inter',
      'A.S. Rome',
      'S.S.C. Napoli',

      'FC Bayern Munich',
      'Bayer Leverkusen',
      'Borussia Dortmund',

      'PSG'
    ];

    var random = function(num) {
      return Math.floor(Math.random() * num);
    };

    $scope.pickTeams = function() {
      var teams = angular.copy(allTeams),
          team1 = random(teams.length),
          team2 = random(teams.length - 1);

      $scope.team1 = teams.splice(team1, 1)[0];
      $scope.team2 = teams.splice(team2, 1)[0];
      $scope.gameStarted = true;
    };
  });
