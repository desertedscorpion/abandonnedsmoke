(function(xvfb, spawn){
    "use strict";
    var recordmydesktop;
    exports.config = {
	//	seleniumServerJar: "./node_modules/protractor/selenium/selenium-server-standalone-2.47.1.jar",
	//	seleniumAddress: "http://localhost:4444/wd/hub",
	directConnect: true,
	specs: [
	    'protractor.spec.js'
	],
	capabilities: {
	    browserName: 'chrome',
	    chromeOptions: {
		"binary": "/usr/bin/chromium-browser"
	    }
	},
	baseUrl: 'http://localhost:8080',
	// The timeout in milliseconds for each script run on the browser. This should
	// be longer than the maximum time your application needs to stabilize between
	// tasks.
	allScriptsTimeout: 11000,
	// How long to wait for a page to load.
	getPageTimeout: 10000,
	framework: 'jasmine',
	beforeLaunch: function(){
	    xvfb.startSync();
	    spawn("recordmydesktop", ["--display", ":96.0", "--on-the-fly-encoding", "--no-sound","-o","protractor.ogv"]).progress(function(success){
		recordmydesktop = success;
	    });
	},
	afterLaunch: function(){
	    spawn("kill", ["--signal", "SIGINT", recordmydesktop.pid]).then(function(success){
		xvfb.stopSync();
	    });
	},
	jasmineNodeOpts: {
	    // If true, print colors to the terminal.
	    showColors: true,
	    // Default time to wait in ms before a test fails.
	    defaultTimeoutInterval: 30000,
	    // Function called to print jasmine results.
	    print: function() {},
	    // If set, only execute specs whose names match the pattern, which is
	    // internally compiled to a RegExp.
	    grep: 'pattern',
	    // Inverts 'grep' matches
	    invertGrep: false
	}
    };
}(
    new (require("xvfb"))({
	"displayNum": "96",
	"reuse": true,
	"xvfb_args": [
	    "-screen",
	    "0",
	    "1280x1024x16"
	]
    }),
    require("child-process-promise").spawn
));
