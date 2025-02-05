import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:netfelix_project/core/colors.dart';
import 'package:netfelix_project/logic/theme/theme_provider.dart';
import 'package:netfelix_project/presentation/screens/home_screen.dart';
import 'package:netfelix_project/presentation/screens/navigation_bot_bar.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context)=>ThemeProvider(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Netfelix',
        debugShowCheckedModeBanner: false,
        home: AnimatedSplashScreen(
          backgroundColor: Colors.black,
          duration: 2000,
          splash:
              Image.asset("assets/images/Logonetflix.png", fit: BoxFit.cover)
                ..animate()
                    .fadeIn(duration: 500.milliseconds)
                    .fadeOut(duration: 500.milliseconds, delay: 1500.milliseconds),
          nextScreen: NavigationBotBar().animate().fadeIn(),
        ),
      theme: Provider.of<ThemeProvider>(context).themeData
    );
  }
}
