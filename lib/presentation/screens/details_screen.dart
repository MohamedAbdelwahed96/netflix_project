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
        if (state is DetailsScreenInitialState)
          return CircleLoading();
        else if (state is DetailsScreenSuccessState) {
          final movie = state.MovieDetails;

          // Map the genreIds to genre names => Find the genre name for each genre ID
          List<String> genreNames = genreIds.map((filmID) => genreList.firstWhere((filmGenre) => filmGenre.id == filmID).name).toList();

          return Scaffold(
            backgroundColor: Colors.black,
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                          "${Paths.Img}original${movie.backdropPath}", fit: BoxFit.cover),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.title.toString() + movie.id.toString(),
                              style: TextStyle(
                                fontFamily: "Lato",
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ).animate().fadeIn(duration: 1.seconds)
                                .moveY(begin: 50, end: 0, duration: 1.seconds, curve: Curves.easeOut),
                            SizedBox(height: 12),
                            Row(
                              children: [
                                Icon(Icons.access_time_rounded,
                                    color: Color.fromRGBO(188, 188, 188, 1),
                                    size: 16),
                                SizedBox(width: 3),
                                Text(
                                  movie.runtime.toString() + " minutes",
                                  style: TextStyle(
                                      fontFamily: "Lato",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Color.fromRGBO(188, 188, 188, 1)),
                                ),
                                SizedBox(width: 24),
                                Icon(Icons.star,
                                    color: Color.fromRGBO(188, 188, 188, 1),
                                    size: 16),
                                SizedBox(width: 3),
                                Text(
                                  movie.voteAverage.toString() + " (IMDb)",
                                  style: TextStyle(
                                      fontFamily: "Lato",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Color.fromRGBO(188, 188, 188, 1)),
                                )
                              ],
                            )
                                .animate().fadeIn(delay: 500.milliseconds, duration: 1.seconds)
                                .moveY(begin: 50, end: 0, delay: 500.milliseconds, duration: 1.seconds, curve: Curves.easeOut),
                            SizedBox(height: 24),
                            Text(
                              "Genre: " + genreNames.join(', '),
                              style: TextStyle(
                                fontFamily: "Lato",
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.white,
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
                                color: Colors.white,
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
                                color: Color.fromRGBO(188, 188, 188, 1),
                              ),
                              moreStyle: TextStyle(
                                  fontFamily: "Lato",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Colors.white),
                              lessStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Colors.white),
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
                            underline: SizedBox(),
                            onChanged: (String? value){
                              value=="Photo"?Navigator.push(context,MaterialPageRoute(builder: (context) => PicsScreen(movieId: movie.id.toString()))):
                              value=="Web"?Navigator.push(context,MaterialPageRoute(builder: (context) => WebPage(website: movie.homepage))):
                              value=="Videos"?Navigator.push(context,MaterialPageRoute(builder: (context) => VideosScreen(movieId: movie.id.toString()))):
                              SizedBox();
                            },
                            items: [
                              DropdownMenuItem(value: "Photo", enabled: movie.backdropPath==""?false:true,
                                  child: Text("Photos & Screens", style: TextStyle(color: movie.backdropPath==""?Colors.grey:Colors.black))),
                              DropdownMenuItem(value: "Web", enabled: movie.homepage==""?false:true,
                                  child: Text("Movie Website", style: TextStyle(color: movie.homepage==""?Colors.grey:Colors.black))),
                              DropdownMenuItem(value: "Videos", child: Text("Videos"))
                            ]),
                      ]
                    )
                  )
                ]
              ),
            )
          );
        } else if (state is DetailsScreenErrorState)
          return Text(state.ErrorMSG);
        else
          return SizedBox();
      }),
    );
  }
}
