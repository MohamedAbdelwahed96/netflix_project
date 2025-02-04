import 'package:netfelix_project/data/movies_data.dart';

class DiscoverGenreStates{}

class DiscoverGenreInitialState extends DiscoverGenreStates{}

class DiscoverGenreLoadingState extends DiscoverGenreStates{}

class DiscoverGenreSuccessState extends DiscoverGenreStates{
  MovieResponse genRes;
  final int totalPages;

  DiscoverGenreSuccessState(this.genRes, this.totalPages);
}

class DiscoverGenreErrorState extends DiscoverGenreStates{
  String errorMSG;
  DiscoverGenreErrorState(this.errorMSG);
}