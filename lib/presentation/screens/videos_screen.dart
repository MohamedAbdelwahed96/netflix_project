import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netfelix_project/core/basic_widgets.dart';
import 'package:netfelix_project/core/colors.dart';
import 'package:netfelix_project/logic/videos_screen_bloc/cubit.dart';
import 'package:netfelix_project/logic/videos_screen_bloc/state.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideosScreen extends StatelessWidget {
  final movieId;
  const VideosScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VideosScreenCubit(Dio())..getVideos(movieId),
      child: BlocBuilder<VideosScreenCubit, VideosScreenStates>(
        builder: (context, state) {
          if (state is VideosScreenLoadingState) {
            return CircleLoading();
          } else if (state is VideosScreenSuccessState){
            final x = state.vid.results;

            return Stack(
              children: [
                Scaffold(
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  body: Padding(
                    padding: const EdgeInsets.all(12),
                    child: ListView.builder(
                        itemCount: x.length,
                        itemBuilder: (context, index) {
                          final movie = x[index];

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: YoutubePlayer(
                                    controller: YoutubePlayerController(
                                      initialVideoId: movie.key,
                                      flags: YoutubePlayerFlags(
                                          autoPlay: false, mute: false, enableCaption: false, hideThumbnail: true),
                                    ),
                                    showVideoProgressIndicator: true,
                                    progressIndicatorColor: ColorsManager.mainRed,
                                    progressColors: ProgressBarColors(
                                      playedColor: ColorsManager.mainRed,
                                      handleColor: ColorsManager.mainRed,
                                    ),

                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(movie.name, style: TextStyle(
                                    fontFamily: "SF Pro Display",
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20.92,
                                    color: Theme.of(context).colorScheme.primary
                                ),)
                              ],
                            ).animate()
                                .fadeIn(delay: Duration(milliseconds: index * 500), duration: 1.seconds, curve: Curves.easeOut)
                                .moveY(begin: 50, end: 0, delay: Duration(milliseconds: index * 500), duration: 1.seconds, curve: Curves.easeOut),
                          );
                        }),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);},
                    icon: Icon(Icons.arrow_back_ios_new, color: Theme.of(context).colorScheme.primary, size: 28)
                )
              ],
            );
          }
          else if (state is VideosScreenErrorState) {
            return Text(state.errorMSG);
          } else {
            return SizedBox();
          }
        }
      )
    );
  }
}