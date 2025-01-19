import 'package:flutter/material.dart';
import 'package:tech/Models/fake_data.dart';
import 'package:tech/gen/assets.gen.dart';
import 'package:url_launcher/url_launcher.dart';

import 'my_colors.dart';

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
              tagList[index].title,
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
