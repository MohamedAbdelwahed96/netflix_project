import 'package:netfelix_project/data/movies_data.dart';

class DiscoverGenreStates{}

class DiscoverGenreInitialState extends DiscoverGenreStates{}

class DiscoverGenreLoadingState extends DiscoverGenreStates{}

class DiscoverGenreSuccessState extends DiscoverGenreStates{
  MovieResponse genRes;

  DiscoverGenreSuccessState(this.genRes);
}

class DiscoverGenreErrorState extends DiscoverGenreStates{
  String errorMSG;
  DiscoverGenreErrorState(this.errorMSG);
}