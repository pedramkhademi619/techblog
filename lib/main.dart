import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tech/binding.dart';
import 'package:tech/components/constants/my_colors.dart';
import 'package:tech/my_http_overrides.dart';
import 'package:tech/view/article/article_list_screen.dart';
import 'package:tech/view/article/single_manage_article.dart';
import 'package:tech/view/main_screen/main_screen.dart';
import 'package:tech/view/article/manage_article.dart';
import 'package:tech/view/article/single.dart';
import 'package:tech/view/podcast/single_manage_podcast.dart';
import 'package:tech/view/splash_screen.dart';

void main() async {
  print("");
  await GetStorage.init();
  HttpOverrides.global = MyHttpOverrides();
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
        getPages: [
          GetPage(
              name: NamedRoute.routeMainScreen,
              page: () => MainScreen(),
              binding: RegisterBinding()),
          GetPage(
              name: NamedRoute.routeSingleArticle,
              page: () => Single(),
              binding: ArticleBinding()),
          GetPage(
              name: NamedRoute.routeListArticle,
              page: () => ArticleListScreen(),
              binding: ArticleBinding()),
          GetPage(
              name: NamedRoute.manageArticle,
              page: () => ManageArticle(),
              binding: ArticleManagerBinding()),
          GetPage(
              name: NamedRoute.singleManageArticle,
              page: () => SingleManageArticle(),
              binding: ArticleManagerBinding()),
          GetPage(
              name: NamedRoute.singleManagepodcast, page: () => SinglePodcast())
        ],
        initialBinding: RegisterBinding(),
        locale: const Locale("fa"),
        theme: lightTheme(context),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen());
  }

  ThemeData lightTheme(BuildContext context) {
    return ThemeData(
        inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
            )),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  const RoundedRectangleBorder()),
              backgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.pressed)) {
                  return SolidColors.seeMore;
                }
                return SolidColors.primaryColor;
              }),
              textStyle: WidgetStateProperty.resolveWith(
                (states) {
                  if (states.contains(WidgetState.pressed)) {
                    return Theme.of(context).textTheme.headlineLarge;
                  }
                  return Theme.of(context).textTheme.labelSmall!.copyWith(
                        fontFamily: 'dana',
                        color: SolidColors.posterSubTitle,
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      );
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
              fontWeight: FontWeight.w700,
            ),
            //headline3
            headlineSmall: const TextStyle().copyWith(
              fontFamily: 'dana',
              color: SolidColors.seeMore,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
            //headline4
            titleSmall: const TextStyle().copyWith(
              fontFamily: 'dana',
              color: const Color.fromARGB(255, 66, 4, 87),
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
            titleLarge: const TextStyle().copyWith(
              fontFamily: 'dana',
              color: const Color.fromARGB(255, 0, 0, 0),
              fontSize: 24,
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
                color: const Color.fromARGB(255, 97, 97, 97))));
  }
}

class NamedRoute {
  NamedRoute._();

  static const String routeMainScreen = "/MainScreen";
  static const String routeSingleArticle = "/SingleArticle";
  static const String routeListArticle = "/ArticleList";
  static const String manageArticle = "/ManageArticle";
  static const String singleManageArticle = "/SingleManageArticle";
  static const String singleManagepodcast = "/SingleManagePodcast";
}
