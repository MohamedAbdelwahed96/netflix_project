import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netfelix_project/core/paths.dart';
import 'package:netfelix_project/logic/genre_bloc/cubit.dart';
import 'package:netfelix_project/logic/genre_bloc/state.dart';
import 'package:netfelix_project/logic/top_rated_bloc/cubit.dart';
import 'package:netfelix_project/logic/top_rated_bloc/state.dart';
import 'package:netfelix_project/presentation/screens/details_screen.dart';
import 'package:netfelix_project/core/basic_widgets.dart';

class TopRatedWidget extends StatefulWidget {
  const TopRatedWidget({super.key});

  @override
  State<TopRatedWidget> createState() => _TopRatedWidgetState();
}

class _TopRatedWidgetState extends State<TopRatedWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopRatedCubit, TopRatedStates>(
        builder: (context, state) {
      if (state is TopRatedLoadingState) {
        return CircleLoading();
      } else if (state is TopRatedSuccessState) {
        final x = state.TopRatedRes.movies;
        return BlocBuilder<GenreCubit, GenreStates>(
          builder: (context, state) {
            if (state is GenreSuccessState) {
              final genreList = state.genre;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 14, top: 12, bottom: 8),
                    child: Text(
                      "Top Rated",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.92,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                  SizedBox(
                    height: 154,
                    child: ListView.builder(
                        itemCount: x.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final movie = x[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailsScreen(
                                                movieID: movie.id,
                                                genreIds: movie.genreIds,
                                                genreList: genreList,
                                              )));
                                },
                                child: Image.network(
                                    "${Paths.Img}w500${movie.posterPath}",
                                    width: 103,
                                    fit: BoxFit.cover, frameBuilder: (context,
                                        child, frame, wasSynchronouslyLoaded) {
                                  return child;
                                }, loadingBuilder:
                                        (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  } else {
                                    return Padding(
                                      padding: const EdgeInsets.all(50),
                                      child: CircleLoading(),
                                    );
                                  }
                                })),
                          )
                              .animate()
                              .moveX(duration: 1.seconds, begin: 50, end: 0);
                        }),
                  )
                ],
              );
            } else {
              return SizedBox();
            }
          },
        );
      } else if (state is TopRatedErrorState) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
          child: Text(state.errorMSG, style: TextStyle(color: Theme.of(context).colorScheme.primary)),
        );
      } else {
        return SizedBox();
      }
    });
  }
}
