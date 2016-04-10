(function(express, spawn, join){
    "use strict";
    var error = function(rageguy){
	return response.json({
	    status: false,
	    error: JSON.stringify(rageguy)
	});
    };
    var run = function(){
	return spawn([
	    "java",
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
	    "-s",
	    "http://localhost:8080"
	].concat(arguments).join(" "));
    };
    return express()
	.use("/", express.static(join(__dirname,"..","client")))
	.get("/rest/api/0.0.0/status/health", function(request, response){
	    return response.json({
		status: true
	    });
	})
	.get("/rest/api/0.0.0/jenkins-cli/genericHelp", function(request, response){
	    return run("help").then(function(success){
		return response.json({
		    status: true,
		    response: success.stderr
		});
	    }, error);
	})
	.get("specificHelp:proc", function(request, response){
	    return run("help", request.params.proc).then(function(success){
		return response.json({
		    status: true,
		    response: JSON.stringify(success)
		});
	    }, error);
	})
	.listen(29615)
    ;
}(
    require("express"),
    require("child-process-promise").exec,
    require("path").join
));
