all: javascripts

javascripts: controller.coffee socketinterface.coffee injectscripts.coffee
	coffee -cj javascripts/controller.js controller.coffee
	coffee -cj javascripts/socketinterface.js socketinterface.coffee
	coffee -cj javascripts/injectscripts.js injectscripts.coffee

