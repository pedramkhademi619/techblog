import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tech/components/constants/dimens.dart';
import 'package:tech/components/constants/my_colors.dart';
import 'package:tech/components/decorations.dart';
import 'package:tech/components/my_components.dart';
import 'package:tech/components/constants/strings.dart';
import 'package:tech/controller/register_controller.dart';
import 'package:tech/gen/assets.gen.dart';
import 'package:tech/view/main_screen/profile_screen.dart';

import 'home_screen.dart';

final GlobalKey<ScaffoldState> key = GlobalKey();

class MainScreen extends StatelessWidget {
  RxInt selectedPageIndex = 0.obs;

  MainScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: key,
        drawer: Drawer(
          backgroundColor: SolidColors.scaffoldBg,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimens.bodyMargin),
            child: ListView(
              children: [
                DrawerHeader(
                  child: Image.asset(Assets.images.logo.path),
                ),
                ListTile(
                  title: Text(
                    "پروفایل کاربری",
                    style: Get.textTheme.titleSmall,
                  ),
                  onTap: () {},
                ),
                const Divider(
                  color: SolidColors.dividerColor,
                ),
                ListTile(
                  title: Text(
                    "درباره تک بلاگ",
                    style: Get.textTheme.titleSmall,
                  ),
                  onTap: () {},
                ),
                const Divider(
                  color: SolidColors.dividerColor,
                ),
                ListTile(
                  title: Text(
                    "اشتراک گذاری تک بلاگ",
                    style: Get.textTheme.titleSmall,
                  ),
                  onTap: () async {
                    await Share.share(MyStrings.shareText);
                  },
                ),
                const Divider(
                  color: SolidColors.dividerColor,
                ),
                ListTile(
                  title: Text(
                    "تک بلاگ در گیت هاب",
                    style: Get.textTheme.titleSmall,
                  ),
                  onTap: () {
                    myLaunchUrl(MyStrings.techBlogGitHubUrl);
                  },
                ),
                const Divider(
                  color: SolidColors.dividerColor,
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  key.currentState!.openDrawer();
                },
              ),
              Image(
                image: Assets.images.logo.provider(),
                height: Get.size.height / 13.6,
              ),
              const Icon(Icons.search),
            ],
          ),
        ),
        body: SafeArea(
          child: Stack(children: [
            Positioned.fill(child: Obx(() {
              return IndexedStack(
                index: selectedPageIndex.value,
                children: [
                  HomeScreen(
                      size: Get.size,
                      textTheme: Get.textTheme,
                      bodyMargin: Dimens.bodyMargin),
                  ProfileScreen(
                      size: Get.size,
                      textTheme: Get.textTheme,
                      bodyMargin: Dimens.bodyMargin)
                ],
              );
            })),
            BottomNav(
              bodyMargin: Dimens.bodyMargin,
              changeScreen: (int pageIndex) {
                selectedPageIndex.value = pageIndex;
              },
            ),
          ]),
        ),
      ),
    );
  }
}

class BottomNav extends StatelessWidget {
  const BottomNav({
    super.key,
    required this.bodyMargin,
    required this.changeScreen,
  });

  final double bodyMargin;
  final Function(int) changeScreen;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: Dimens.bodyMargin,
      bottom: 8,
      left: Dimens.bodyMargin,
      child: Container(
        height: Get.size.height / 10,
        decoration: MyDecoration.mainGradiant,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: bodyMargin),
          child: Container(
            height: Get.size.height / 8,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(18)),
              gradient: LinearGradient(
                colors: GradiantColors.bottomNav,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () => changeScreen(0),
                  icon: ImageIcon(Assets.icons.home.provider()),
                  color: Colors.white,
                ),
                IconButton(
                  onPressed: () {
                    Get.find<RegisterController>().toggleLogin();
                  },
                  icon: ImageIcon(Assets.icons.write.provider()),
                  color: Colors.white,
                ),
                IconButton(
                  onPressed: () => changeScreen(1),
                  icon: ImageIcon(Assets.icons.user.provider()),
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
