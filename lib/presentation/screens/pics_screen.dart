import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netfelix_project/core/basic_widgets.dart';
import 'package:netfelix_project/core/paths.dart';
import 'package:netfelix_project/logic/pics_screen_bloc/cubit.dart';
import 'package:netfelix_project/logic/pics_screen_bloc/state.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PicsScreen extends StatelessWidget {
  final movieId;

  const PicsScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PicsScreenCubit(Dio())..getImages(movieId),
      child: BlocBuilder<PicsScreenCubit, PicsScreenStates>(
        builder: (context, state) {
          if (state is PicsScreenLoadingState)
            return CircleLoading();
          else if (state is PicsScreenSuccessState) {
            final x = state.img.backdrops;

            return Scaffold(
              backgroundColor: Colors.black,
              body: Padding(
                padding: const EdgeInsets.all(24),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 14,
                          crossAxisSpacing: 14),
                      itemCount: x.length,
                      itemBuilder: (context, index) {
                        final movie = x[index];

                        return InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                    builder: (_) => PhotoViewGallery.builder(
                                          itemCount: x.length,
                                          builder: (context, index) {
                                            final movie = x[index];

                                            return PhotoViewGalleryPageOptions(
                                                imageProvider: NetworkImage("${Paths.Img}original${movie.filePath}"),
                                                minScale: PhotoViewComputedScale.contained,
                                                maxScale: PhotoViewComputedScale.covered);
                                          },
                                          pageController: PageController(initialPage: index),
                                          loadingBuilder: (context, event) => CircleLoading()),
                                    ));
                          },
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network("${Paths.Img}w500${movie.filePath}",
                                  width: MediaQuery.of(context).size.width * .4,
                                  fit: BoxFit.fitHeight, frameBuilder: (context,
                                      child, frame, wasSynchronouslyLoaded) {
                                return child;
                              }, loadingBuilder:
                                      (context, child, loadingProgress) {
                                if (loadingProgress == null)
                                  return child;
                                else
                                  return Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: CircleLoading()
                                  );
                              }).animate().fadeIn(delay: Duration(milliseconds: index * 150),
                                  duration: 1.seconds,
                                  curve: Curves.easeOut)),
                        );
                      }),
                ),
              ),
            );
          } else if (state is PicsScreenErrorState)
            return Text(state.errormsg);
          else
            return SizedBox();
        }
      )
    );
  }
}
