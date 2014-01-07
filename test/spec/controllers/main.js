'use strict';

describe('Controller: MainCtrl', function() {

  // load the controller's module
  beforeEach(module('furetApp'));

  var MainCtrl,
    scope;

  // Initialize the controller and a mock scope
  beforeEach(inject(function ($controller, $rootScope) {
    scope = $rootScope.$new();
    MainCtrl = $controller('MainCtrl', {
      $scope: scope
    });
  }));

  it('should attach a list of teams to the scope', function() {
    expect(scope.teams.length).toBe(15);
  });

  describe('#pickTeams', function() {
    beforeEach(function(){
      scope.pickTeams();
    })

    it('should attach two teams from the list to the scope', function() {
      expect(scope.teams).toContain(scope.team1);
      expect(scope.teams).toContain(scope.team2);
    }

    it('should attach two diffrent teams to the scope', function() {
      expect(scope.team1).toBeDefined();
      expect(scope.team2).toBeDefined();
      expect(scope.team1).not.toEqual(scope.team2)
    })
  })
});
