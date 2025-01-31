import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:tech/components/my_colors.dart';
import 'package:tech/components/my_components.dart';
import 'package:tech/controller/article/list_article_controller.dart';
import 'package:tech/controller/article/manage_article_controller.dart';
import 'package:tech/gen/assets.gen.dart';
import 'package:tech/view/article/article_list_screen.dart';

class SingleManageArticle extends StatelessWidget {
  SingleManageArticle({super.key});

  ManageArticleController manageArticleController =
      Get.find<ManageArticleController>();
  Rx<String> file = "nothing".obs;
  Future<dynamic> imagePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      file.value = result.files.single.path!;
    }
  }

  @override
  Widget build(BuildContext context) {
    RxBool select = false.obs;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(children: [
                    CachedNetworkImage(
                      imageUrl:
                          manageArticleController.articleInfoModel.value.image!,
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
                    Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              imagePicker();
                            },
                            child: Container(
                              height: 40,
                              width: 100,
                              decoration: const BoxDecoration(
                                  color: SolidColors.primaryColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                  )),
                            ),
                          ),
                        ))
                  ]),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
                    child: Text(
                      manageArticleController.articleInfoModel.value.title!,
                      style: Get.textTheme.headlineLarge!
                          .copyWith(color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  file.value == "nothing"?SizedBox.shrink(): Image.file(File(file.value)),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 16, 16, 16),
                    child: Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: SolidColors.seeMore,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: HtmlWidget(
                      manageArticleController.articleInfoModel.value.content!,
                      enableCaching: true,
                      textStyle: Get.textTheme.titleMedium,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  // tags(),
                ],
              )),
        ),
      ),
    );
  }

  Widget tags() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: manageArticleController.tagList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              await Get.find<ListArticleController>().getArticleListWithTagsId(
                  manageArticleController.tagList[index].id!);
              Get.to(ArticleListScreen(
                title: manageArticleController.tagList[index].title,
              ));
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
                    child: Text(manageArticleController.tagList[index].title!)),
              ),
            ),
          );
        },
      ),
    );
  }
}
