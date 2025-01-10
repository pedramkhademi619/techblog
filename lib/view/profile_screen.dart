import 'package:flutter/material.dart';

import '../gen/assets.gen.dart';
import '../my_colors.dart';
import '../my_components.dart';
import '../strings.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    required this.size,
    required this.textTheme,
    required this.bodyMargin,
  });

  final Size size;
  final TextTheme textTheme;
  final double bodyMargin;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: Assets.images.avatar.provider(),
              height: 100,
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageIcon(
                  Assets.icons.bluepen.provider(),
                  color: SolidColors.seeMore,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  MyStrings.editImageProfile,
                  style: textTheme.headlineSmall,
                ),
              ],
            ),
            const SizedBox(
              height: 60,
            ),
            Text(
              "فاطمه میرزایی",
              style: textTheme.titleSmall,
            ),
            Text(
              "fatemeh656@gmail.com",
              style: textTheme.titleSmall,
            ),
            const SizedBox(
              height: 40,
            ),
            TechDivider(size: size),
            InkWell(
              splashColor: SolidColors.primaryColor,
              splashFactory: InkSparkle.splashFactory,
              onTap: () {},
              child: SizedBox(
                  height: 45,
                  child: Center(
                      child: Text(
                    MyStrings.myFavoriteBlogs,
                    style: textTheme.titleSmall,
                  ))),
            ),
            TechDivider(size: size),
            InkWell(
              splashColor: SolidColors.primaryColor,
              splashFactory: InkSparkle.splashFactory,
              onTap: () {},
              child: SizedBox(
                  height: 45,
                  child: Center(
                      child: Text(
                    MyStrings.myFavoritepodcasts,
                    style: textTheme.titleSmall,
                  ))),
            ),
            TechDivider(size: size),
            InkWell(
              splashColor: SolidColors.primaryColor,
              splashFactory: InkSparkle.splashFactory,
              onTap: () {},
              child: SizedBox(
                  height: 45,
                  child: Center(
                      child: Text(
                    MyStrings.logOut,
                    style: textTheme.titleSmall,
                  ))),
            ),
            const SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }
}
