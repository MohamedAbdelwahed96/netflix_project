import 'package:flutter/material.dart';
import 'package:netfelix_project/presentation/screens/categories_screen.dart';
import 'package:netfelix_project/presentation/screens/home_screen.dart';
import 'package:netfelix_project/presentation/screens/pics_screen.dart';

class NavigationBotBar extends StatefulWidget {
  const NavigationBotBar({super.key});

  @override
  State<NavigationBotBar> createState() => _NavigationBotBarState();
}

class _NavigationBotBarState extends State<NavigationBotBar> {
  int selectedPageIndex = 0;

  void selectedPage(int index){
    setState(() => selectedPageIndex = index);
  }
  @override
  Widget build(BuildContext context) {
    Widget activePage = HomeScreen();
    if(selectedPageIndex==1) {
      activePage = CategoriesScreen();
    }
    if(selectedPageIndex==2)
      activePage = PicsScreen(movieId: "558449"); // test


    return Scaffold(
      body: activePage,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashFactory: NoSplash.splashFactory,
        ),
      child: Container(
          decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Color.fromRGBO(243, 29, 28, 1)))),
          child: BottomNavigationBar(
              selectedItemColor: Color.fromRGBO(243, 29, 28, 1), // Selected label color
              unselectedItemColor: Colors.grey,
              backgroundColor: Colors.black,
          onTap: selectedPage,
          iconSize: 36,
          currentIndex: selectedPageIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.movie), label: "Categories"),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorites")
          ]),
        ),
      ) ,
    );
  }
}
