import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech/components/my_components.dart';
import 'package:tech/controller/home_screen_controller.dart';
import 'package:tech/controller/list_article_controller.dart';
import 'package:tech/controller/single_article_controller.dart';
import 'package:tech/view/article_list_screen.dart';

import '../../Models/fake_data.dart';
import '../../components/my_colors.dart';
import '../../components/strings.dart';
import '../../gen/assets.gen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    super.key,
    required this.size,
    required this.textTheme,
    required this.bodyMargin,
  });

  final HomeScreenController homeScreenController =
      Get.put(HomeScreenController());

  final SingleArticleController singleArticleController =
      Get.put(SingleArticleController());
  final ListArticleController listArticleController =
      Get.put(ListArticleController());
  final Size size;
  final TextTheme textTheme;
  final double bodyMargin;

  @override
  Widget build(BuildContext context) {
    homeScreenController.getHomeItems();
    return Obx(
      () => homeScreenController.loading.value == false
          ? SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  poster(),

                  const SizedBox(
                    height: 16,
                  ),

                  // tag list
                  tags(),
                  const SizedBox(
                    height: 32,
                  ),

                  //see more
                  SeeMore(bodyMargin: bodyMargin, textTheme: textTheme),

                  //blog list
                  topVisited(),

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

                  topPodcast(),

                  const SizedBox(
                    height: 60,
                  ),
                ],
              ))
          : loading(),
    );
  }

  Widget topVisited() {
    return SizedBox(
      height: size.height / 3.5,
      child: Obx(
        () => ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: homeScreenController.topVisitedList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  singleArticleController.getArticleInfo(
                      homeScreenController.topVisitedList[index].id);
                },
                child: Padding(
                  padding: EdgeInsets.only(right: index == 0 ? bodyMargin : 15),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: SizedBox(
                          height: size.height / 5.3,
                          width: size.width / 2.4,
                          child: Stack(children: [
                            CachedNetworkImage(
                              imageUrl: homeScreenController
                                  .topVisitedList[index].image!,
                              placeholder: (context, url) => loading(),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.image_not_supported,
                                color: Colors.grey,
                                size: 50,
                              ),
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                foregroundDecoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                    gradient: LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        colors: GradiantColors.blogPost)),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(16),
                                  ),
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
                                    homeScreenController
                                        .topVisitedList[index].author!,
                                    style: textTheme.labelSmall,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        homeScreenController
                                            .topVisitedList[index].view!,
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
                            homeScreenController.topVisitedList[index].title!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          )),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  Widget topPodcast() {
    return SizedBox(
      height: size.height / 3.5,
      child: Obx(
        () => ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: homeScreenController.topPodcastList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(right: index == 0 ? bodyMargin : 15),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: size.height / 5.3,
                        width: size.width / 2.4,
                        child: CachedNetworkImage(
                          errorWidget: (context, url, error) => const Icon(
                            Icons.image_not_supported,
                            size: 50,
                            color: Colors.grey,
                          ),
                          placeholder: (context, url) => loading(),
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          imageUrl: homeScreenController
                              .topPodcastList[index].poster!,
                        ),
                      ),
                    ),
                    Text(
                      homeScreenController.topPodcastList[index].title!,
                      style: textTheme.titleSmall,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }

  Widget tags() {
    return SizedBox(
      height: 60,
      child: Obx(
        () => ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: homeScreenController.tagsList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                   listArticleController.getArticleListWithTagsId(
                      homeScreenController.tagsList[index].id!);

                  Get.to(ArticleListScreen(
                      title: homeScreenController.tagsList[index].title!));
                },
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, 8, index == 0 ? bodyMargin : 15, 8),
                  child: MainTags(index: index, textTheme: textTheme),
                ),
              );
            }),
      ),
    );
  }

  Widget poster() {
    return Stack(
      children: [
        Container(
          height: size.height / 4.2,
          width: size.width / 1.25,
          foregroundDecoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              gradient: LinearGradient(
                  colors: GradiantColors.homeposterCoverGradiant,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: CachedNetworkImage(
              // imageUrl: homeScreenController.poster.value.image ?? "",

              //"If the above line has been written,
              // there is no need to wrap the columns with Obx,
              // and RxBool is not required."

              // When the above line is used,
              // the poster in the UI is handled right there
              // if it receives a null value.
              // It waits until it gets the correct value and
              // does not throw an error. However,
              // if it is not used,
              // since the poster does not receive data simultaneously with
              // other values,
              // it may receive data later than other UI elements
              // and remain null. Because of the null value,
              // it throws an error,
              // which we have managed using a different approach.

              imageUrl: homeScreenController.poster.value.image!,
              imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        )),
                    foregroundDecoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        gradient: LinearGradient(
                            colors: GradiantColors.homeposterCoverGradiant,
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                  ),
              placeholder: (context, url) => loading(),
              errorWidget: (context, url, error) {
                return const Icon(Icons.image_not_supported,
                    size: 50, color: Colors.grey);
              }),
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
                // homeScreenController.poster.value.title??"",

                homeScreenController.poster.value.title!,
                style: textTheme.headlineLarge,
              )
            ],
          ),
        ),
      ],
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
    return GestureDetector(
      onTap: () {
        Get.to(() => ArticleListScreen());
      },
      child: Padding(
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
      ),
    );
  }
}
