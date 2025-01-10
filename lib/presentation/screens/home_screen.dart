import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netfelix_project/logic/genre_bloc/cubit.dart';
import 'package:netfelix_project/logic/now_playing_bloc/cubit.dart';
import 'package:netfelix_project/logic/popular_bloc/cubit.dart';
import 'package:netfelix_project/logic/top_rated_bloc/cubit.dart';
import 'package:netfelix_project/logic/upcoming_bloc/cubit.dart';
import 'package:netfelix_project/presentation/widgets/now_playing_widget.dart';
import 'package:netfelix_project/presentation/widgets/popular_widget.dart';
import 'package:netfelix_project/presentation/widgets/top_rated_widget.dart';
import 'package:netfelix_project/presentation/widgets/upcoming_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => NowPlayingCubit(Dio())..getNowPlayingMovies()),
          BlocProvider(create: (context) => PopularCubit(Dio())..getPopularMovies()),
          BlocProvider(create: (context) => TopRatedCubit(Dio())..getTopRatedMovies()),
          BlocProvider(create: (context) => UpcomingCubit(Dio())..getUpcomingMovies()),
          BlocProvider(create: (context) => GenreCubit(Dio())..getGenre())
        ],
        child: Scaffold(
          backgroundColor: Colors.black,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NowPlayingWidget().animate().fadeIn(duration: 1.seconds),
                PopularWidget().animate().fadeIn(delay: 750.milliseconds, duration: 1.seconds).moveX(begin: -14, end: 0,delay: 750.milliseconds, duration: 1.seconds, curve: Curves.easeOut),
                TopRatedWidget().animate().fadeIn(delay: 1500.milliseconds, duration: 1.seconds).moveX(begin: -14, end: 0,delay: 1500.milliseconds, duration: 1.seconds, curve: Curves.easeOut),
                UpcomingWidget().animate().fadeIn(delay: 2250.milliseconds, duration: 1.seconds).moveX(begin: -14, end: 0,delay: 2250.milliseconds, duration: 1.seconds, curve: Curves.easeOut)
              ],
            ),
          ),
        ));
  }
}
