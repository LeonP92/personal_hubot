# Description:
#   The places to eat all around Tysons
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot where to eat? - Get a random restaurant
#	hubot list restaurants - List all the hip and cool restaurants around Tysons
#	hubot remove restaurant <restaurant> - Remove a restaurant from the list of cool places
# 	hubot add restaurant <restaurant> - Add a restaurant to the list of hip places
#
# Author: Leon Pham

restaurants = [
	"Wildfire",
	"Food trucks",
	"Chipotle",
	"PF Changs",
	"Pauls",
	"Elevation Burger",
	"McDonalds"
]

module.exports = (robot) -> 
	
	robot.respond /where to eat?/i, (msg) ->
		randomRestaurant = msg.random restaurants
		msg.send "I think you should eat at #{randomRestaurant}!"

	robot.respond /list restaurants/i, (msg) ->
		restaurantString = ""

		for restaurant in restaurants
			restaurantString = restaurantString + "#{restaurant}\n"

		msg.send "Here are the restaurants: \n#{restaurantString}"

	robot.respond /remove restaurant (.*)/i, (msg) ->
		restaurant = escape(msg.match[1])
		

		indexOfRestaurant = restaurants.indexOf(restaurant)

		if (indexOfRestaurant != -1) 
			restaurants.splice(/indexOfRestaurant/i, 1)
			msg.send "#{restaurant} has been removed!"
		else 
			msg.send "#{restaurant} is not in the list!"
		

	robot.respond /add restaurant (.*)/i, (msg) ->
		restaurant = escape(msg.match[1]) 

		if (restaurant.match(/QDOBA/ig))
			msg.send "No. Qdoba will never be on this list!"
			return;

		indexOfRestaurant = restaurants.indexOf(restaurant)

		if (indexOfRestaurant != -1) 
			msg.send "#{restaurant} is already in the list!" 
		else
			restaurants.push restaurant
			msg.send "#{restaurant} has been added!"


