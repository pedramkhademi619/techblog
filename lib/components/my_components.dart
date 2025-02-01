import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tech/components/constants/strings.dart';
import 'package:tech/controller/home_screen_controller.dart';
import 'package:tech/gen/assets.gen.dart';
import 'package:url_launcher/url_launcher.dart';

import 'constants/my_colors.dart';

class TechDivider extends StatelessWidget {
  const TechDivider({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: SolidColors.dividerColor,
      indent: size.width / 6,
      endIndent: size.width / 6,
      thickness: 1.5,
    );
  }
}

class MainTags extends StatelessWidget {
  const MainTags({
    super.key,
    required this.index,
    required this.textTheme,
  });
  final int index;
  final TextTheme textTheme;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: GradiantColors.tags,
              begin: Alignment.bottomRight,
              end: Alignment.centerLeft),
          borderRadius: BorderRadius.all(Radius.circular(24))),
      height: 60,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
        child: Row(
          children: [
            ImageIcon(
              Assets.icons.hashtagicon.provider(),
              color: Colors.white,
              size: 14,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              Get.find<HomeScreenController>().tagsList[index].title!,
              style: textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}

myLaunchUrl(String url) async {
  Uri uri = Uri.parse(url);

  // if (await canLaunchUrl(uri)) {
  await launchUrl(uri);
  // } else {
  // print('Could not launch $url');
  // }
}

Widget loading() => const SpinKitFadingCube(
      color: SolidColors.primaryColor,
      size: 32,
    );

PreferredSize appBar(String title, context) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(80),
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Center(
              child: Text(title,
                  style: const TextStyle(
                      color: SolidColors.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'dana')),
            ),
          ),
        ],
        leading: Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: InkWell(
            onTap: () => Get.back(),
            child: Ink(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: SolidColors.primaryColor.withAlpha(100)),
              child: const Icon(CupertinoIcons.arrow_right),
            ),
          ),
        ),
      ),
    ),
  );
}

class SeeMoreBlog extends StatelessWidget {
  const SeeMoreBlog({
    super.key,
    required this.bodyMargin,
    required this.textTheme,
    required this.title,
  });

  final double bodyMargin;
  final TextTheme textTheme;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: bodyMargin, bottom: 8),
      child: Row(
        children: [
          ImageIcon(
            Assets.icons.bluepen.provider(),
            color: SolidColors.seeMore,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            title,
            style: textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
