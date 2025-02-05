import 'package:flutter/material.dart';
import 'package:netfelix_project/core/colors.dart';
import 'package:netfelix_project/logic/theme/theme_provider.dart';
import 'package:netfelix_project/presentation/screens/categories_screen.dart';
import 'package:netfelix_project/presentation/screens/home_screen.dart';
import 'package:provider/provider.dart';

class NavigationBotBar extends StatefulWidget {
  const NavigationBotBar({super.key});

  @override
  State<NavigationBotBar> createState() => _NavigationBotBarState();
}

class _NavigationBotBarState extends State<NavigationBotBar> {
  bool isActive=true;
  int selectedPageIndex = 0;

  void selectedPage(int index){
    setState(() => selectedPageIndex = index);
  }
  @override
  Widget build(BuildContext context) {

    Widget activePage = HomeScreen();

    if(selectedPageIndex==1){
      activePage=CategoriesScreen();
    }

    return Scaffold(
      body: activePage,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashFactory: NoSplash.splashFactory,
        ),
      child: Container(
          decoration: BoxDecoration(
              border: Border(top: BorderSide(color: ColorsManager.mainRed))),
          child: BottomNavigationBar(
              selectedItemColor: ColorsManager.mainRed,
              unselectedItemColor: Colors.grey,
              backgroundColor: Theme.of(context).colorScheme.surface,
          onTap: selectedPage,
          iconSize: 36,
          currentIndex: selectedPageIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.movie), label: "Categories"),
            BottomNavigationBarItem(icon:

            Switch(
                value: isActive,
                onChanged: (value){
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
              setState(() => isActive=value);}),

                label: "")
          ]),
        ),
      ) ,
    );
  }
}
