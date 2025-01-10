import 'package:flutter/material.dart';

import '../gen/assets.gen.dart';
import '../my_colors.dart';
import 'home_screen.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

final GlobalKey<ScaffoldState> key = GlobalKey();
class _MainScreenState extends State<MainScreen> {
  var selectedPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double bodyMargin = size.width / 10;
    var textTheme = Theme.of(context).textTheme;

    return SafeArea(
      
      child: Scaffold(
        key: key,
        drawer: Drawer(
          backgroundColor: SolidColors.scaffoldBg,
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: bodyMargin),
            child: ListView(
              children: [
                DrawerHeader(
                  child: Image.asset(Assets.images.logo.path),
                ),
                ListTile(
                  title: Text(
                    "پروفایل کاربری",
                    style: textTheme.titleSmall,
                  ),
                  onTap: () {},
                ),
                const Divider(
                  color: SolidColors.dividerColor,
                ),
                ListTile(
                  title: Text(
                    "درباره تک بلاگ",
                    style: textTheme.titleSmall,
                  ),
                  onTap: () {},
                ),
                const Divider(
                  color: SolidColors.dividerColor,
                ),
                ListTile(
                  title: Text(
                    "اشتراک گذاری تک بلاگ",
                    style: textTheme.titleSmall,
                  ),
                  onTap: () {},
                ),
                const Divider(
                  color: SolidColors.dividerColor,
                ),
                ListTile(
                  title: Text(
                    "تک بلاگ در گیت هاب",
                    style: textTheme.titleSmall,
                  ),
                  onTap: () {},
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
                height: size.height / 13.6,
              ),
              const Icon(Icons.search),
            ],
          ),
        ),
        body: SafeArea(
          child: Stack(children: [
            Positioned.fill(
                child: IndexedStack(
              index: selectedPageIndex,
              children: [
                HomeScreen(
                    size: size, textTheme: textTheme, bodyMargin: bodyMargin),
                ProfileScreen(
                    size: size, textTheme: textTheme, bodyMargin: bodyMargin)
              ],
            )),
            BottomNav(
              size: size,
              bodyMargin: bodyMargin,
              changeScreen: (int pageIndex) {
                setState(() {
                  selectedPageIndex = pageIndex;
                });
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
    required this.size,
    required this.bodyMargin,
    required this.changeScreen,
  });

  final Size size;
  final double bodyMargin;
  final Function(int) changeScreen;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      bottom: 0,
      left: 0,
      child: Container(
        height: size.height / 10,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: GradiantColors.bottomNavBackGround,
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: bodyMargin),
          child: Container(
            height: size.height / 8,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(36)),
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
                  onPressed: () {},
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
