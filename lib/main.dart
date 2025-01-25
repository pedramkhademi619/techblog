import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:tech/components/my_colors.dart';
import 'package:tech/view/main_screen/main_screen.dart';

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
    return GetMaterialApp(
        locale: const Locale("fa"),
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
                  color: const Color.fromARGB(255, 0, 0, 0),
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
                //caption
                bodySmall: const TextStyle().copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'dana',
                    color: const Color.fromARGB(255, 97, 97, 97)))),
        debugShowCheckedModeBanner: false,
        home: MainScreen());
  }
}
