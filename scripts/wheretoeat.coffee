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
# 	hubot add restaurant <restaurant> <price> - Add a restaurant to the list of hip places. Price must be $ characters, 1 to 5 of them.
#	hubot explain pricing - Explains what the dollar signs means
#
# Author: 
# 	Leon Pham

# Should have a better way to do this. Don't the slick coffeescript way of getting a random key in a map
restaurants = [
	"Wildfire",
	"Food trucks",
	"Chipotle",
	"PF Changs",
	"Pauls",
	"Elevation Burger",
	"McDonalds"
]

priceOfRestaurants = {
	"Wildfire":"$$$",
	"Food trucks":"$",
	"Chipotle":"$",
	"PF Changs":"$$",
	"Pauls":"$$",
	"Elevation Burger":"$",
	"McDonalds":"$"
}

module.exports = (robot) -> 
	robot.respond /explain pricing/i, (msg) ->
		msg.send "Here you go:\n$ - Cheap\n$$ - Moderately cheap\n$$$ - Feeling a bit fancy\n$$$$ - Eat here all the time and you'll go bankrupt\n$$$$$ - 1%"

	robot.respond /where to eat?/i, (msg) ->
		randomRestaurant = msg.random restaurants
		msg.send "I think you should eat at #{randomRestaurant} - #{priceOfRestaurants[randomRestaurant]}"

	robot.respond /list restaurants/i, (msg) ->
		restaurantString = ""

		for restaurant in restaurants
			restaurantString = restaurantString + "#{restaurant} - #{priceOfRestaurants[restaurant]}\n"

		msg.send "Here are the restaurants: \n#{restaurantString}"

	robot.respond /remove restaurant (.*)/i, (msg) ->
		# TODO: This is hackish. Should find a way to unencode URLs.
		restaurant = escape(msg.match[1]).replace(/%20/g, " ").replace(/%27/g, "'")

		indexOfRestaurant = restaurants.indexOf(restaurant)

		if (indexOfRestaurant != -1) 
			restaurants.splice(/indexOfRestaurant/i, 1)
			delete priceOfRestaurants[restaurant]
			msg.send "#{restaurant} has been removed!"
		else 
			msg.send "#{restaurant} is not in the list!"
		

	robot.respond /add restaurant (.*)/i, (msg) ->
		# TODO: This is hackish. Should find a way to unencode URLs.
		restaurant = escape(msg.match[1]).replace(/%20/g, " ").replace(/%24/g, "$").replace(/%27/g, "'")
		tempArray = restaurant.split(" ")

		if (tempArray.length != 2)
			msg.send "HEY! you gave me #{tempArray.length} argument! I need two! Learn to read!"
			return

		restaurantName = tempArray[0]
		restaurantPrice = tempArray[1]

		if (restaurantPrice.match(/\${1,5}/g))
			if (restaurantName.match(/QDOBA/ig))
				msg.send "No. Qdoba will never be on this list!"
				return

			indexOfRestaurant = restaurants.indexOf(restaurantName)

			if (indexOfRestaurant != -1)
				msg.send "#{restaurantName} is already in the list!"
			else
				priceOfRestaurants[restaurantName] = restaurantPrice
				restaurants.push restaurantName
				msg.send "#{restaurantName} has been added!"
		else
			msg.send "You need to give me the price in dollar signs (1 to 5) as the second argument!"
