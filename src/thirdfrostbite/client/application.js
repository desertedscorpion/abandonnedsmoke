(function(){
    "use strict";
    return angular.module("application", ["ngResource"])
	.directive("application", function(){
	    return {
		restrict: "E",
		templateUrl: "application.html",
		controller: "controller"
	    };
	})
	.controller("controller", ["$scope", "service", function($scope, service){
	    service.health().then(function(health){
		$scope.health = health;
	    });
	    service.genericHelp().then(function(help){
		$scope.genericHelp = help;
	    });
	}])
	.service("service", ["$resource", function($resource){
	    this.health = function(){
		return $resource("rest/api/0.0.0/status/health").get().$promise;
	    };
	    this.genericHelp = function(){
		return $resource("rest/api/0.0.0/jenkins-cli/help").get().$promise;
	    };
	}])
    ;
}());
