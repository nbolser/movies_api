# Usage

### Start the app

`$ rake start`

### Run specs

`$ rake`

### cURL

#### Movies

* http://localhost:9292/movies
* http://localhost:9292/movies?page=4

#### Movie Details

* http://localhost:9292/movies/1421/details

#### Movies By Year

* http://localhost:9292/movies/search?releaseDate=1999

* http://localhost:9292/movies/search?releaseDate=1999&page=6

* http://localhost:9292/movies/search?releaseDate=1999&page=4&order=DESC

* http://localhost:9292/movies/search?releaseDate=1999&page=6&order=ASC


#### Movies By Genre

* http://localhost:9292/movies/search?genres=Action

* http://localhost:9292/movies/search?genres=Drama&page=10

