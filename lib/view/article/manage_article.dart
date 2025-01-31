import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tech/components/my_components.dart';
import 'package:tech/components/strings.dart';
import 'package:tech/controller/article/manage_article_controller.dart';
import 'package:tech/gen/assets.gen.dart';
import 'package:tech/main.dart';

class ManageArticle extends StatelessWidget {
  var articleManageController = Get.find<ManageArticleController>();
  var size = Get.size;
  @override
  Widget build(BuildContext context) {
    var textTheme = Get.textTheme;
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: ElevatedButton(
        style: ButtonStyle(
            fixedSize: WidgetStateProperty.all<Size>(Size(Get.width / 3, 56))),
        onPressed: () {
          Get.toNamed(NamedRoute.singleManageArticle);
        },
        child: const Text(
          "بریم برای نوشتن یه مقاله باحال",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      appBar: appBar("مدیریت مقاله", context),
      body: Obx(
        () => articleManageController.loading.value == true
            ? loading()
            : articleManageController.articleList.isNotEmpty
                ? ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: articleManageController.articleList.length,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            //TODO route single manage
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CachedNetworkImage(
                                placeholder: (context, url) => loading(),
                                errorWidget: (context, url, error) {
                                  return const Icon(
                                    Icons.image_not_supported,
                                    size: 50,
                                    color: Colors.grey,
                                  );
                                },
                                imageUrl: articleManageController
                                    .articleList[index].image!,
                                imageBuilder: (context, imageProvider) {
                                  return Container(
                                    height: size.height / 6,
                                    width: size.width / 3,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(16)),
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover)),
                                  );
                                },
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: size.width / 2,
                                      child: Text(
                                        articleManageController
                                            .articleList[index].title!,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          articleManageController
                                              .articleList[index].author!,
                                          style: textTheme.bodySmall,
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          "${articleManageController.articleList[index].view!} بازدید",
                                          style: textTheme.bodySmall,
                                        ),
                                      ],
                                    ),
                                    Align(
                                      widthFactor: 3,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        articleManageController
                                                    .articleList[index]
                                                    .status ==
                                                "0"
                                            ? "تایید شده"
                                            : articleManageController
                                                        .articleList[index]
                                                        .status ==
                                                    "1"
                                                ? "در انتظار تایید"
                                                : "پیش نویس",
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    )
                                  ])
                            ],
                          ),
                        ),
                      );
                    }))
                : articleEmptyState(textTheme),
      ),
    ));
  }

  Widget articleEmptyState(TextTheme textTheme) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          Assets.icons.emptytcbot.path,
          height: 100,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: MyStrings.articleEmpty, style: textTheme.titleSmall),
          ),
        ),
      ],
    ));
  }
}
