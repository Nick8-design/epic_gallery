import 'package:epic_gallery/theme/style.dart';
import 'package:epic_gallery/ui/HomePage.dart';

import 'package:epic_gallery/ui/MainPage.dart';
import 'package:epic_gallery/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:desktop_window/desktop_window.dart';

import 'data/provider.dart';


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  if (isDesktop()) {
    await DesktopWindow.setWindowSize(const Size(600, 600));
    await DesktopWindow.setMinWindowSize(const Size(260, 600));
  }
  final sharedPrefs = await SharedPreferences.getInstance();

  runApp(ProviderScope(overrides: [
    sharedPrefProvider.overrideWithValue(sharedPrefs),
  ], child: const MyApp()));
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(


    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      appBarTheme: AppBarTheme(
      titleTextStyle: AppBarTextStyle,


    ),
    textTheme:
    TextTheme(
    titleMedium: TitleStyle,
    bodyMedium: Body1TextSyle,
    ),

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:  CollapsibleMenuExample(),
    );
  }
}
