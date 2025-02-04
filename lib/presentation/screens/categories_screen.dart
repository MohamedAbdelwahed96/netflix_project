import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netfelix_project/core/basic_widgets.dart';
import 'package:netfelix_project/core/colors.dart';
import 'package:netfelix_project/logic/genre_bloc/cubit.dart';
import 'package:netfelix_project/logic/genre_bloc/state.dart';
import 'package:netfelix_project/presentation/screens/movies_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => GenreCubit(Dio())..getGenre(),
      child: BlocBuilder<GenreCubit,GenreStates>(builder: (context, state) {
        if(state is GenreLoadingState) {
          return CircleLoading();
        } else if (state is GenreSuccessState){
          final x = state.genre;
          return Scaffold(
            backgroundColor: Colors.black,
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20),
                itemCount: x.length,
                itemBuilder: (context, index){
                  final genre = x[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>MoviesScreen(genID: genre.id)));

                      print("film genre === " + genre.id.toString()); // test
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(colors: [
                          ColorsManager.mainRed.withOpacity(0.54),
                          ColorsManager.mainRed.withOpacity(0.9)
                        ])
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(genre.name,style: TextStyle(
                            fontFamily: "SF Pro Display",
                            fontWeight: FontWeight.w700,
                            fontSize: 20.92,
                            color: Colors.white)),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }
        else if(state is GenreErrorState) {
          return Text(state.errorMSG);
        } else {
          return SizedBox();
        }
      }),
    );
  }
}
