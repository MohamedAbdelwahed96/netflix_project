import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netfelix_project/core/basic_widgets.dart';
import 'package:netfelix_project/core/paths.dart';
import 'package:netfelix_project/logic/genre_bloc/cubit.dart';
import 'package:netfelix_project/logic/genre_bloc/state.dart';
import 'package:netfelix_project/logic/related_bloc/cubit.dart';
import 'package:netfelix_project/logic/related_bloc/state.dart';
import 'package:netfelix_project/presentation/screens/details_screen.dart';

class RelatedWidget extends StatefulWidget {
  const RelatedWidget({super.key});

  @override
  State<RelatedWidget> createState() => _RelatedWidgetState();
}

class _RelatedWidgetState extends State<RelatedWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RelatedCubit, RelatedStates>(
        builder: (context, state) {
      if (state is RelatedLoadingState)
        return CircleLoading();
      else if (state is RelatedSuccessState) {
        final x = state.movRes.movies;
        return BlocBuilder<GenreCubit, GenreStates>(
          builder: (context, state) {
            if (state is GenreSuccessState) {
              final genreList = state.genre;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Related Movies",
                    style: TextStyle(
                        fontFamily: "Lato",
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    height: 106,
                    child: ListView.builder(
                        itemCount: x.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final movie = x[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
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
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                      movie.backdropPath==null?"${Paths.Img}w500${movie.posterPath}":"${Paths.Img}w500${movie.backdropPath}",
                                      width: 142,
                                      fit: BoxFit.cover, frameBuilder: (context,
                                      child, frame, wasSynchronouslyLoaded) {
                                    return child;
                                  }, loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null)
                                      return child;
                                    else
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 50),
                                        child: CircleLoading(),
                                      );
                                  }),
                                )),
                          ).animate().moveX(duration: 1.seconds, begin: 50, end: 0);
                        }),
                  )
                ],
              );
            } else
              return SizedBox();
          },
        );
      } else if (state is RelatedErrorState)
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
          child: Text(state.ErrorMsg, style: TextStyle(color: Colors.white)),
        );
      else
        return SizedBox();
    });
  }
}
