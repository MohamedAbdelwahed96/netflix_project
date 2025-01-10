import 'package:netfelix_project/data/movies_data.dart';

class GenreStates {}

class GenreInitialState extends GenreStates {}

class GenreLoadingState extends GenreStates {}

class GenreSuccessState extends GenreStates {
  List<Genre> genre;
  GenreSuccessState(this.genre);
}

class GenreErrorState extends GenreStates {
  String errorMSG;
  GenreErrorState(this.errorMSG);
}
