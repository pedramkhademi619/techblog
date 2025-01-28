import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:tech/components/my_colors.dart';
import 'package:tech/components/my_components.dart';
import 'package:tech/controller/list_article_controller.dart';
import 'package:tech/controller/single_article_controller.dart';
import 'package:tech/gen/assets.gen.dart';
import 'package:tech/view/article_list_screen.dart';



class Single extends StatelessWidget {
  SingleArticleController singleArticleController =
      Get.put(SingleArticleController());

  Single({super.key});

 
  @override
  Widget build(BuildContext context) {
    RxBool select = false.obs;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Obx(
            () => singleArticleController.loading.value == false
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(children: [
                        CachedNetworkImage(
                          imageUrl: singleArticleController
                              .articleInfoModel.value.image!,
                          imageBuilder: (context, imageProvider) =>
                              Image(image: imageProvider),
                          placeholder: (context, url) => loading(),
                          errorWidget: (context, url, error) =>
                              Image.asset(Assets.images.singlePlaceHolder.path),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          left: 0,
                          child: Container(
                            height: 60,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: GradiantColors.singleAppbarGradiant),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    CupertinoIcons.arrow_right,
                                    color: Colors.white,
                                  ),
                                  onPressed: () => Get.back(),
                                ),
                                const Expanded(child: SizedBox()),
                                IconButton(
                                  onPressed: () {
                                    select.value = !select.value;
                                  },
                                  icon: Icon(
                                      select.value == false
                                          ? Icons.bookmark_add_outlined
                                          : Icons.bookmark_remove,
                                      color: Colors.white),
                                ),
                                const SizedBox(
                                  width: 32,
                                ),
                                const Icon(Icons.share, color: Colors.white),
                              ],
                            ),
                          ),
                        ),
                      ]),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
                        child: Text(
                          singleArticleController.articleInfoModel.value.title!,
                          style: Get.textTheme.headlineLarge!
                              .copyWith(color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.person,
                              color: SolidColors.seeMore,
                            ),
                            Text(
                              singleArticleController
                                  .articleInfoModel.value.author!,
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Text(singleArticleController
                                    .articleInfoModel.value.createdAt ??
                                "دو روز پیش"),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: HtmlWidget(
                          singleArticleController
                              .articleInfoModel.value.content!,
                          enableCaching: true,
                          textStyle: Get.textTheme.titleMedium,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      tags(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 30, 16, 16),
                        child: Text(
                          "نوشته های مرتبط",
                          style: Get.textTheme.headlineSmall,
                        ),
                      ),
                      related(),
                    ],
                  )
                : SizedBox(height: Get.height,child: loading()),
          ),
        ),
      ),
    );
  }

  Widget tags() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: singleArticleController.tags.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              await Get.find<ListArticleController>().getArticleListWithTagsId(
                  singleArticleController.tags[index].id!);
              Get.to(ArticleListScreen(title: singleArticleController.tags[index].title,));
              
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 40,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                    child: Text(singleArticleController.tags[index].title!)),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget related() {
    double bodyMargin = Get.width / 10;
    return SizedBox(
      height: Get.height / 3.5,
      child: Obx(
        () => ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: singleArticleController.related.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(right: index == 0 ? bodyMargin : 15),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: SizedBox(
                        height: Get.height / 5.3,
                        width: Get.width / 2.4,
                        child: Stack(children: [
                          CachedNetworkImage(
                            imageUrl:
                                singleArticleController.related[index].image!,
                            placeholder: (context, url) => loading(),
                            errorWidget: (context, url, error) => const Icon(
                              Icons.image_not_supported,
                              color: Colors.grey,
                              size: 50,
                            ),
                            imageBuilder: (context, imageProvider) => Container(
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  singleArticleController
                                      .related[index].author!,
                                  style: Get.textTheme.labelSmall,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      singleArticleController
                                          .related[index].view!,
                                      style: Get.textTheme.labelSmall,
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
                        width: Get.width / 2.4,
                        child: Text(
                          singleArticleController.related[index].title!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        )),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
