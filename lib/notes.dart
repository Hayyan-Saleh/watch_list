// movie lists :
  
  // first add the string /movies/

    // to get now playing movies ( Get a list of movies that are currently in theatres ): add the string now_playing
    // to get popular movies (Get a list of movies ordered by popularity) : add the string popular
    // to get top rated  movies ( Get a list of movies ordered by rating ): add the string top_rated
    // to get now upcoming movies ( Get a list of movies that are being released soon ) : add the string upcoming

  // first add the string /trending/movie/

    // to get today's most trending movies : add the string day
    // to get this week's most trending movies : add the string week
 

// movie images :

  // add the following

    // add the movie poster_path or backDrop_path (gives you one image for the specific movie)

// movie videos : 

  // first add the string /movie/{MOVIE_ID}/videos?api_key=YOUR_API_KEY

    //ensure to add your movie id !!

// get the movie details based on the id :

  // first add the string /movie/

    //after this you must add the movie id then the api key like : MOVIE_ID?api_key=0000

// search for movie : 


  // first add the string /search/movie/

    // it takes the attribute query which holds the name of movie 'title' (IT IS REQUIRED) 
    // other params : 1- include_adult ( boolean ) 2- year ( string ) 3- region ( string )

      // it should be like : https://api.themoviedb.org/3/search/movie?query=The%20Family%20Gay&include_adult=false&language=en-US&page=1

