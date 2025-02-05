import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netfelix_project/core/colors.dart';
import 'package:netfelix_project/core/paths.dart';
import 'package:netfelix_project/logic/genre_bloc/cubit.dart';
import 'package:netfelix_project/logic/genre_bloc/state.dart';
import 'package:netfelix_project/logic/now_playing_bloc/cubit.dart';
import 'package:netfelix_project/logic/now_playing_bloc/state.dart';
import 'package:netfelix_project/presentation/screens/details_screen.dart';
import 'package:netfelix_project/core/basic_widgets.dart';
import 'package:pulsator/pulsator.dart';

class NowPlayingWidget extends StatefulWidget {
  const NowPlayingWidget({super.key});

  @override
  State<NowPlayingWidget> createState() => _NowPlayingWidgetState();
}

class _NowPlayingWidgetState extends State<NowPlayingWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NowPlayingCubit, NowPlayingStates>(
        builder: (context, state) {
      if (state is NowPlayingLoadingState) {
        return CircleLoading();
      } else if (state is NowPlayingSuccessState) {
        final x = state.NowPlayingRes.movies;

        return BlocBuilder<GenreCubit, GenreStates>(builder: (context, state) {
          if (state is GenreSuccessState) {
            final genreList = state.genre;
            return Stack(children: [
              SizedBox(
                height: 370,
                child: ListView.builder(
                    itemCount: x.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final movie = x[index];
                      return InkWell(
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
                        child: AnimatedOpacity(
                          duration: Duration(milliseconds: 300),
                          opacity: Theme.of(context).brightness == Brightness.dark ? 0.75 : 1.0,
                          child: Image.network(
                              "${Paths.Img}original${movie.backdropPath}",
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover, frameBuilder: (context, child,
                                  frame, wasSynchronouslyLoaded) {
                            return child;
                          }, loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              {
                                return Padding(
                                  padding: const EdgeInsets.all(150),
                                  child: CircleLoading(),
                                );
                              }
                            }
                          }),
                        ),
                      );
                    }),
              ),
              Padding(
                padding: EdgeInsets.only(top: 320),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PulseIcon(
                      icon: Icons.fiber_manual_record,
                      pulseColor: ColorsManager.mainRed,
                      iconColor: ColorsManager.mainRed,
                      iconSize: 10,
                      innerSize: 15,
                      pulseSize: 40,
                      pulseCount: 2,
                      pulseDuration: Duration(seconds: 2),
                    ),
                    Text(
                      "Now Playing",
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 24,
                          color: Colors.white),
                    ),
                  ],
                ),
              )
            ]);
          } else {
            return SizedBox();
          }
        });
      } else if (state is NowPlayingErrorState) {
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
