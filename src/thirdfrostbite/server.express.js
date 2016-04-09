(function(express, spawn){
    "use strict";
    return express()
	.get("/rest/api/0.0.0/status/health", function(request, response){
	    return response.json({
		status: true
	    });
	})
	.get("/rest/api/0.0.0/jenkins-cli/help", function(request, response){
	    return spawn("java", [
		"-classpath",
		[
		    "/opt/thirdfrostbite/localizer-1.9.jar",
		    "/opt/thirdfrostbite/commons-codec-1.9.jar",
		    "/usr/share/jenkins/webroot/WEB-INF/jenkins-cli.jar",
		    "/usr/share/jenkins/webroot/WEB-INF/remoting.jar",
		    "/usr/share/jenkins/webroot/WEB-INF/slave.jar",
		    "/usr/share/jenkins/webroot/WEB-INF/classes:localizer-1.9.jar"
		].join(":"),
		"hudson.cli.CLI",
		"help"
	    ]).then(function(success){
		return response.json({
		    status: true,
		    stdout: success.stdout,
		    stderr: success.stderr
		});
	    }, function(rageguy){
		return response.json({
		    status: false,
		    error: JSON.stringify(rageguy)
		});
	    });
	})
	.listen(29615)
    ;
}(
    require("express"),
    require("child-process-promise").spawn
));
