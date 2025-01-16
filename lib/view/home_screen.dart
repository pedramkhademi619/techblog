import 'package:flutter/material.dart';
import 'package:tech/components/my_components.dart';

import '../Models/fake_data.dart';
import '../gen/assets.gen.dart';
import '../components/my_colors.dart';
import '../components/strings.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({
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
      child: Column(
        children: [
          HomePagePoster(size: size, textTheme: textTheme),
    
          const SizedBox(
            height: 16,
          ),
    
          // tag list
          HomePageTagList(bodyMargin: bodyMargin, textTheme: textTheme,),
          const SizedBox(
            height: 32,
          ),
    
          //see more
          SeeMore(bodyMargin: bodyMargin, textTheme: textTheme),
    
          //blog list
          HomePageBlogList(size: size, bodyMargin: bodyMargin, textTheme: textTheme),
    
          Padding(
            padding: EdgeInsets.only(right: bodyMargin),
            child: Row(
              children: [
                ImageIcon(
                  Assets.icons.bluemic.provider(),
                  color: SolidColors.seeMore,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  MyStrings.viewHottestPodCasts,
                  style: textTheme.headlineSmall,
                )
              ],
            ),
          ),
    
          SeeMorePodCast(size: size, bodyMargin: bodyMargin, textTheme: textTheme),
          const SizedBox(
            height: 60,
          ),
        ],
      ),
    );
  }
}

class SeeMorePodCast extends StatelessWidget {
  const SeeMorePodCast({
    super.key,
    required this.size,
    required this.bodyMargin,
    required this.textTheme,
  });

  final Size size;
  final double bodyMargin;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height / 3.5,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: podCastList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(
                  right: index == 0 ? bodyMargin : 15),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      podCastList[index].imageUrl,
                      width: 150,
                    ),
                  ),
                  Text(
                    podCastList[index].title,
                    style: textTheme.titleSmall,
                  ),
                ],
              ),
            );
          }),
    );
  }
}

class HomePageBlogList extends StatelessWidget {
  const HomePageBlogList({
    super.key,
    required this.size,
    required this.bodyMargin,
    required this.textTheme,
  });

  final Size size;
  final double bodyMargin;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height / 3.5,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: blogList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(
                  right: index == 0 ? bodyMargin : 15),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(
                      height: size.height / 5.3,
                      width: size.width / 2.4,
                      child: Stack(children: [
                        Container(
                          foregroundDecoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(16)),
                              gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: GradiantColors.blogPost)),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    blogList[index].imageUrl),
                                fit: BoxFit.cover),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(16),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 8,
                          right: 3,
                          left: 0,
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                blogList[index].writer,
                                style: textTheme.labelSmall,
                              ),
                              Row(
                                children: [
                                  Text(
                                    blogList[index].views,
                                    style: textTheme.labelSmall,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Icon(
                                    Icons.remove_red_eye_sharp,
                                    color: Colors.white,
                                    weight: 16,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ),
                  SizedBox(
                      width: size.width / 2.4,
                      child: Text(
                        blogList[index].title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      )),
                      
                ],
              ),
            );
          }),
    );
  }
}

class SeeMore extends StatelessWidget {
  const SeeMore({
    super.key,
    required this.bodyMargin,
    required this.textTheme,
  });

  final double bodyMargin;
  final TextTheme textTheme;

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
            MyStrings.viewHottestBlog,
            style: textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}

class HomePageTagList extends StatelessWidget {
  const HomePageTagList({
    super.key,
    required this.bodyMargin,
    required this.textTheme,
  });

  final double bodyMargin;
final TextTheme textTheme;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: tagList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.fromLTRB(
                  0, 8, index == 0 ? bodyMargin : 15, 8),
              child:  MainTags(index: index,textTheme: textTheme),
            );
          }),
    );
  }
}



class HomePagePoster extends StatelessWidget {
  const HomePagePoster({
    super.key,
    required this.size,
    required this.textTheme,
  });

  final Size size;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: size.height / 4.2,
          width: size.width / 1.25,
          decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.all(Radius.circular(16)),
              image: DecorationImage(
                image: AssetImage(homePagePosterMap["imageAsset"]),
                fit: BoxFit.cover,
              )),
          foregroundDecoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              gradient: LinearGradient(
                  colors: GradiantColors.homeposterCoverGradiant,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
        ),
        Positioned(
          right: 0,
          left: 0,
          bottom: 8,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    homePagePosterMap["writer"] +
                        "  -  " +
                        homePagePosterMap["date"],
                    style: textTheme.labelSmall,
                  ),
                  Row(
                    children: [
                      Text(homePagePosterMap["view"],
                          style: textTheme.labelSmall),
                      const SizedBox(
                        width: 8,
                      ),
                      const Icon(
                        Icons.remove_red_eye_sharp,
                        color: Colors.white,
                        size: 16,
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                "دوازده قدم برنامه نویسی یک دوره ی ... س",
                style: textTheme.headlineLarge,
              )
            ],
          ),
        ),
      ],
    );
  }
}
