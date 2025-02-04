class Paths {
  static const String apiKey = "?api_key=0e56004f55365c73dbfae5234655fbcd";
  static const String baseURL = "https://api.themoviedb.org/3/movie/";
  static const String NowPlayingURL = "${baseURL}now_playing$apiKey";
  static const String PopularURL = "${baseURL}popular$apiKey";
  static const String TopRatedURL = "${baseURL}top_rated$apiKey";
  static const String UpcomingURL = "${baseURL}upcoming$apiKey";
  static const String Img = "https://image.tmdb.org/t/p/";
  static const String Genre = "https://api.themoviedb.org/3/genre/movie/list$apiKey";
  static const String Discover="https://api.themoviedb.org/3/discover/movie$apiKey";
}