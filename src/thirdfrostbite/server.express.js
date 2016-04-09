(function(express){
    "use strict";
    return express()
	.get("/rest/api/0.0.0/status/health", function(request, response){
	    return response.json({
		status: true
	    });
	})
	.listen(29615)
}(
    require("express")
));
