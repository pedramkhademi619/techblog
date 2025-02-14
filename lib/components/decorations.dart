import 'package:flutter/cupertino.dart';
import 'package:tech/components/constants/my_colors.dart';

class MyDecoration {
  MyDecoration._();
  static const BoxDecoration mainGradiant =  BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(18)),
    gradient: LinearGradient(
      colors: GradiantColors.bottomNav,
    ),
  );
}
