all: javascripts

javascripts: controller.coffee
	coffee -cj javascripts/controller.js controller.coffee
