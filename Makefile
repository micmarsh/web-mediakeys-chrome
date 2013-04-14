all: javascripts

javascripts: controller.coffee socketinterface.coffee
	coffee -cj javascripts/controller.js controller.coffee
	coffee -cj javascripts/socketinterface.js socketinterface.coffee
