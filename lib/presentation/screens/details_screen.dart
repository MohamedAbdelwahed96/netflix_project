import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netfelix_project/core/basic_widgets.dart';
import 'package:netfelix_project/core/paths.dart';
import 'package:netfelix_project/data/movies_data.dart';
import 'package:netfelix_project/logic/details_screen_bloc/cubit.dart';
import 'package:netfelix_project/logic/details_screen_bloc/state.dart';
import 'package:netfelix_project/logic/genre_bloc/cubit.dart';
import 'package:netfelix_project/logic/related_bloc/cubit.dart';
import 'package:netfelix_project/presentation/screens/pics_screen.dart';
import 'package:netfelix_project/presentation/screens/videos_screen.dart';
import 'package:netfelix_project/presentation/screens/web_page.dart';
import 'package:netfelix_project/presentation/widgets/default_image_widget.dart';
import 'package:netfelix_project/presentation/widgets/related_widget.dart';
import 'package:readmore/readmore.dart';

class DetailsScreen extends StatelessWidget {
  final movieID;
  final List<int> genreIds;
  final List<Genre> genreList;

  const DetailsScreen({super.key, required this.movieID, required this.genreIds, required this.genreList});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DetailsScreenCubit(Dio())..getMovieData(movieID)),
        BlocProvider(create: (context) => RelatedCubit(Dio())..getRelatedMovies(movieID)),
        BlocProvider(create: (context) => GenreCubit(Dio())..getGenre()),
      ],
      child: BlocBuilder<DetailsScreenCubit, DetailsScreenStates>(
          builder: (context, state) {
        if (state is DetailsScreenInitialState) {
          return CircleLoading();
        } else if (state is DetailsScreenSuccessState) {
          final movie = state.MovieDetails;

          // Map the genreIds to genre names => Find the genre name for each genre ID
          final genreNames = genreIds.map((id) => genreList.firstWhere((genre) => genre.id == id).name).toList();

          print("film id === " + movieID.toString()); // test

          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height*0.33,
                        child: movie.backdropPath==""?DefaultImageWidget(text: movie.title):Image.network(
                            "${Paths.Img}original${movie.backdropPath}",
                            fit: BoxFit.cover),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${movie.title} (${movie.releaseDate.substring(0,4)})",
                              style: TextStyle(
                                fontFamily: "Lato",
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ).animate().fadeIn(duration: 1.seconds)
                                .moveY(begin: 50, end: 0, duration: 1.seconds, curve: Curves.easeOut),
                            SizedBox(height: 12),
                            Row(
                              children: [
                                Icon(Icons.access_time_rounded,
                                    color: Theme.of(context).colorScheme.secondary,
                                    size: 16),
                                SizedBox(width: 3),
                                Text(
                                  "${movie.runtime} minutes",
                                  style: TextStyle(
                                      fontFamily: "Lato",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Theme.of(context).colorScheme.secondary),
                                ),
                                SizedBox(width: 24),
                                Icon(Icons.star,
                                    color: Theme.of(context).colorScheme.secondary,
                                    size: 16),
                                SizedBox(width: 3),
                                Text(
                                  "${movie.voteAverage} (IMDb)",
                                  style: TextStyle(
                                      fontFamily: "Lato",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Theme.of(context).colorScheme.secondary),
                                )
                              ],
                            )
                                .animate().fadeIn(delay: 500.milliseconds, duration: 1.seconds)
                                .moveY(begin: 50, end: 0, delay: 500.milliseconds, duration: 1.seconds, curve: Curves.easeOut),
                            SizedBox(height: 24),
                            Text(
                              "Genre: ${genreNames.join(", ")}",
                              style: TextStyle(
                                fontFamily: "Lato",
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            )
                                .animate().fadeIn(delay: 1.seconds, duration: 1.seconds)
                                .moveY(begin: 50, end: 0, delay: 1.seconds, duration: 1.seconds, curve: Curves.easeOut),
                            SizedBox(height: 24),
                            Text(
                              "Descreption",
                              style: TextStyle(
                                fontFamily: "Lato",
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            )
                                .animate().fadeIn(delay: 1500.milliseconds, duration: 1.seconds)
                                .moveY(begin: 50, end: 0, delay: 1500.milliseconds, duration: 1.seconds, curve: Curves.easeOut),
                            SizedBox(height: 12),
                            ReadMoreText(
                              movie.overview,
                              trimMode: TrimMode.Line,
                              trimLines: 3,
                              colorClickableText: Colors.pink,
                              trimCollapsedText: "Read more",
                              trimExpandedText: " Read less",

                              style: TextStyle(
                                fontFamily: "Lato",
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              moreStyle: TextStyle(
                                  fontFamily: "Lato",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Theme.of(context).colorScheme.primary),
                              lessStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Theme.of(context).colorScheme.primary),
                            )
                                .animate().fadeIn(delay: 1500.milliseconds, duration: 1.seconds)
                                .moveY(begin: 50, end: 0, delay: 1500.milliseconds, duration: 1.seconds, curve: Curves.easeOut),
                            SizedBox(height: 24),
                            RelatedWidget()
                                .animate().fadeIn(delay: 2000.milliseconds, duration: 1.seconds)
                                .moveX(begin: -24, end: 0, delay: 2000.milliseconds, duration: 1.seconds, curve: Curves.easeOut),
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 44, horizontal: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);},
                            icon: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 28)
                            ),
                        DropdownButton(
                            icon: Icon(Icons.more_vert,color: Colors.white, size: 28),
                            style: TextStyle(color: Colors.black),
                            dropdownColor: Colors.white,
                            underline: SizedBox(),
                            onChanged: (String? value){
                              value=="Photos"?Navigator.push(context,MaterialPageRoute(builder: (context) => PicsScreen(movieId: movie.id.toString()))):
                              value=="Videos"?Navigator.push(context,MaterialPageRoute(builder: (context) => VideosScreen(movieId: movie.id.toString()))):
                              value=="Web"?Navigator.push(context,MaterialPageRoute(builder: (context) => WebPage(website: movie.homepage))):
                              SizedBox();
                            },
                            items: [
                              DropdownMenuItem(value: "Photos", enabled: movie.backdropPath==""?false:true,
                                  child: Text("Photos & Screens", style: TextStyle(color: movie.backdropPath==""?Colors.grey:Colors.black))),
                              DropdownMenuItem(value: "Videos", child: Text("Videos")),
                              DropdownMenuItem(value: "Web", enabled: movie.homepage==""?false:true,
                                  child: Text("Website", style: TextStyle(color: movie.homepage==""?Colors.grey:Colors.black)))

                            ]),
                      ]
                    )
                  )
                ]
              ),
            )
          );
        } else if (state is DetailsScreenErrorState) {
          return Text(state.errorMSG);
        } else {
          return SizedBox();
        }
      }),
    );
  }
}
