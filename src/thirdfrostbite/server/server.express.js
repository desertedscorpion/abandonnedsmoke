(function(express, spawn, join){
    "use strict";
    return express()
	.use("/", express.static(join(__dirname,"..","client")))
	.get("/rest/api/0.0.0/status/health", function(request, response){
	    return response.json({
		status: true
	    });
	})
	.get("/rest/api/0.0.0/jenkins-cli/help", function(request, response){
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
		"http://localhost:8080",
		"help"
	    ].join(" ")).then(function(success){
		return response.json({
		    status: true,
		    response: success.stderr.split("\n").map(function(line, index, array){
			if(0 === index % 2){
			    return [line, array[index+1]];
			}
		    }).filter(function(line, index, array){
			return 0 === index % 2;
		    })
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
    require("child-process-promise").exec,
    require("path").join
));
