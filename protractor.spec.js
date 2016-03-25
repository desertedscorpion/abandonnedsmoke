(function(){
    "use strict";
    describe("protractor tests", function(){
	beforeEach(function(){
	    browser.get("/");
	    browser.sleep(1000*60*30);
	});
	it("works", function(){
	    expect(element(by.css("#job_desertedscorpion-strawsound > td:nth-child(1) > img")).getAttribute("tooltip")).toEqual("Success");
	    expect(element(by.css("#job_desertedscorpion-strawsound > td:nth-child(3) > a")).getText()).toEqual("desertedscorpion-strawsound");
	});
    });
}());
