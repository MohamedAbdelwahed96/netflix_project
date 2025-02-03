import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netfelix_project/core/basic_widgets.dart';
import 'package:netfelix_project/core/paths.dart';
import 'package:netfelix_project/logic/discover_genre_bloc/cubit.dart';
import 'package:netfelix_project/logic/discover_genre_bloc/state.dart';
import 'package:netfelix_project/logic/genre_bloc/cubit.dart';
import 'package:netfelix_project/logic/genre_bloc/state.dart';
import 'package:netfelix_project/presentation/screens/details_screen.dart';

class MoviesScreen extends StatefulWidget {
  final int genID;
  const MoviesScreen({required this.genID});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  int activeIndex=0;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DiscoverGenreCubit(Dio())..getGenre(widget.genID,1)),
        BlocProvider(create: (context) => GenreCubit(Dio())..getGenre())
      ],
      child: BlocBuilder<DiscoverGenreCubit,DiscoverGenreStates>(builder: (context,state){
        if(state is DiscoverGenreLoadingState)
          return CircleLoading();
        else if(state is DiscoverGenreSuccessState){
          final x = state.genRes.movies;

          return BlocBuilder<GenreCubit, GenreStates>(
            builder: (context, state){
              if (state is GenreSuccessState){
                final genreList = state.genre;

                return Scaffold(
                  backgroundColor: Colors.black,
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height*0.85,
                          child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 20),
                            itemCount: x.length,
                            itemBuilder: (context, index){
                              final movie = x[index];
                              return InkWell(
                                onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(
                                    movieID: movie.id, genreIds: movie.genreIds, genreList: genreList))),
                                child: Image.network(
                                    "${Paths.Img}w500${movie.posterPath}",
                                    fit: BoxFit.fitHeight, frameBuilder:
                                    (context, child, frame,
                                    wasSynchronouslyLoaded) {
                                  return child;
                                }, loadingBuilder: (context, child,
                                    loadingProgress) {
                                  if (loadingProgress == null)
                                    return child;
                                  else
                                    return Padding(
                                      padding: const EdgeInsets.all(50),
                                      child: CircleLoading(),
                                    );
                                }),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.8,
                          height: MediaQuery.of(context).size.height*0.1,
                          child: ListView.builder(
                              itemCount: 500,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context,index){
                                bool isActive = activeIndex == index;
                                return Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    child: InkWell(
                                      onTap: (){
                                        final page=index+1;
                                        setState(() => activeIndex=index);
                                        context.read<DiscoverGenreCubit>().getGenre(widget.genID, page);
                                      },
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: isActive?Color.fromRGBO(243, 29, 28, 1):null,
                                        border: Border.all(color: Color.fromRGBO(243, 29, 28, 1))),
                                        child: Center(child: Text("${index+1}",
                                          style: TextStyle(
                                            color: isActive?Colors.black:Color.fromRGBO(243, 29, 28, 1)),)),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                  ),
                );
              }
              else
                return SizedBox();
            }
          );
        }
        else if(state is DiscoverGenreErrorState)
          return Text(state.err);
        else
          return SizedBox();
      }),
    );
  }
}
