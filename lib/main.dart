import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tech/view/main_screen.dart';
import 'package:tech/view/my_cats.dart';

import 'my_colors.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: SolidColors.statusBarColor,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: SolidColors.systemNavigationBarColor,
      systemNavigationBarIconBrightness: Brightness.dark));
  runApp(const HomePage());
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      theme: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
              )),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.pressed)) {
                return SolidColors.seeMore;
              }
              return SolidColors.primaryColor;
            }), textStyle: WidgetStateProperty.resolveWith(
              (states) {
                if (states.contains(WidgetState.pressed)) {
                  return Theme.of(context).textTheme.headlineLarge;
                }
                return Theme.of(context).textTheme.labelSmall;
              },
            )),
          ),
          fontFamily: 'dana',
          textTheme: TextTheme(
            //headline 1
            headlineLarge: const TextStyle().copyWith(
              fontFamily: 'dana',
              color: SolidColors.posterTitle,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
            //headLine2
            headlineMedium: const TextStyle().copyWith(
              fontFamily: 'dana',
              color: SolidColors.posterSubTitle,
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
            //headline3
            headlineSmall: const TextStyle().copyWith(
              fontFamily: 'dana',
              color: SolidColors.seeMore,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
            //headline4
            titleSmall: const TextStyle().copyWith(
              fontFamily: 'dana',
              color: const Color.fromARGB(255, 66, 4, 87),
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
            //headline5
            titleMedium: const TextStyle().copyWith(
              fontFamily: 'dana',
              color: SolidColors.hintText,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),

            //subtitle1
            labelSmall: const TextStyle().copyWith(
              fontFamily: 'dana',
              color: SolidColors.posterSubTitle,
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          )),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fa'), // Persian
      ],
      home: const MyCats(),
    );
  }
}
