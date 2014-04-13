To do list
==========
* Data
	* ~~Coords from KML~~
	* ~~Coords that weren't in KML~~
	* ~~Better format data specifics~~
	* ~~Convert data to GeoJSON~~
* Map by season
	* http://elesdoar.github.io/leaflet-control-orderlayers/
* Map markers
	* Colors
		* Choropleth http://blog.thehumangeo.com/tag/leaflet/
	* Sizes
	* Shape
* Add stats to popup
	* Graph stats in popups
* Website wrapper with purpose, info, etc.
* Map by stats?
* Animation


Links
=====
* [ABC map](https://maps.google.com/maps/ms?msa=0&msid=207303117555710580147.0004cccef4743cbbddec0&ie=UTF8&t=m&ll=33.788849,-84.379463&spn=0.13696,0.219727&z=12&source=embed)
* [Full data](https://www.dropbox.com/sh/i1pdkccpto3rcgk/8kvUniSjZr)

What files are
==============
* raw-data.csv: data from ABC data link above
* locations-long.csv & locations.csv: locations of count sites, from ABC map where possible, else from google maps
* cleaning.R: takes raw-data.csv and aggregates it by season, intersection, and time of day
* seasonal.csv: cleaned data from R script
* counts.js: GeoJSON format of seasonal.csv