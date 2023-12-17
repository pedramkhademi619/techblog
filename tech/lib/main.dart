import 'package:flutter/material.dart';
import 'package:tech/gen/assets.gen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'Strings.dart';

void main() {
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
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('fa'), // Persian
      ],
      home: Scaffold(
        body: Center(
          child: Image(image: Assets.images.icon.provider()),
        ),
      ),
    );
  }
}
