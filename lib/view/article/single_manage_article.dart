import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:tech/components/constants/dimens.dart';
import 'package:tech/components/constants/my_colors.dart';
import 'package:tech/components/my_components.dart';
import 'package:tech/controller/article/manage_article_controller.dart';
import 'package:tech/controller/file_controller.dart';
import 'package:tech/controller/home_screen_controller.dart';
import 'package:tech/gen/assets.gen.dart';
import 'package:tech/services/pick_file.dart';
import 'package:tech/view/article/article_content_editor.dart';

class SingleManageArticle extends StatelessWidget {
  SingleManageArticle({super.key});

  ManageArticleController manageArticleController =
      Get.find<ManageArticleController>();

  FilePickerController filePickerController = Get.put(FilePickerController());

  getTitle() {
    Get.defaultDialog(
        confirm: ElevatedButton(
            onPressed: () {
              manageArticleController.updateTitle();
              Get.back();
            },
            child: const Text(
              "ثبت",
              style: TextStyle(color: SolidColors.scaffoldBg),
            )),
        radius: 8,
        titleStyle: const TextStyle(color: SolidColors.scaffoldBg),
        backgroundColor: SolidColors.primaryColor,
        title: "عنوان مقاله",
        content: TextField(
          controller: manageArticleController.titleTextEditingController,
          style: const TextStyle(color: SolidColors.colorTitle),
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(hintText: "اینجا بنویس"),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(children: [
                    SizedBox(
                      height: Get.height / 3,
                      width: Get.width,
                      child: filePickerController.file.value.name == "nothing"
                          ? CachedNetworkImage(
                              imageUrl: manageArticleController
                                  .articleInfoModel.value.image!,
                              imageBuilder: (context, imageProvider) =>
                                  Image(image: imageProvider),
                              placeholder: (context, url) => loading(),
                              errorWidget: (context, url, error) => Image.asset(
                                Assets.images.singlePlaceHolder.path,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Image.file(
                              File(filePickerController.file.value.path!),
                              fit: BoxFit.cover,
                            ),
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
                              pickFile();
                            },
                            child: Container(
                              height: 30,
                              width: Get.width / 3,
                              decoration: const BoxDecoration(
                                  color: SolidColors.primaryColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                  )),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "انتخاب تصویر",
                                    style: Get.textTheme.headlineMedium,
                                  ),
                                  const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ))
                  ]),
                  const SizedBox(
                    height: 24,
                  ),
                  GestureDetector(
                    onTap: () {
                      getTitle();
                    },
                    child: SeeMoreBlog(
                        bodyMargin: Dimens.halfBodyMargin,
                        textTheme: Get.textTheme,
                        title: "ویرایش عنوان مقاله"),
                  ),
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
                  GestureDetector(
                    onTap: () => Get.to(() => ArticleContentEditor()),
                    child: SeeMoreBlog(
                        bodyMargin: Dimens.halfBodyMargin,
                        textTheme: Get.textTheme,
                        title: "ویرایش متن اصلی مقاله"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: HtmlWidget(
                      manageArticleController.articleInfoModel.value.content!,
                      enableCaching: true,
                      textStyle: Get.textTheme.titleMedium,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      chooseCatsBottomSheet(Get.textTheme);
                    },
                    child: SeeMoreBlog(
                        bodyMargin: Dimens.halfBodyMargin,
                        textTheme: Get.textTheme,
                        title: "انتخاب دسته بندی"),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
                    child: Text(
                      manageArticleController.articleInfoModel.value.catName ??
                          "هیچ دسته بندی انتخاب نشده!",
                      style: Get.textTheme.headlineLarge!
                          .copyWith(color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  Center(
                      child: ElevatedButton(
                          onPressed: () async {
                            await manageArticleController.storeArticle();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              manageArticleController.loading.value
                                  ? "صبر کنید..."
                                  : "ارسال مطلب",
                              style: Get.textTheme.headlineMedium,
                            ),
                          ))),
                ],
              )),
        ),
      ),
    );
  }

  Widget cats() {
    HomeScreenController homeScreenController =
        Get.find<HomeScreenController>();
    return SizedBox(
      height: Get.height / 1.7,
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        itemCount: homeScreenController.tagsList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              manageArticleController.articleInfoModel.update((value) {
                value!.catName = homeScreenController.tagsList[index].title!;
                value.catId = homeScreenController.tagsList[index].id!;
              });
              Get.back();
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Container(
                height: 30,
                width: 60,
                decoration: BoxDecoration(
                  color: SolidColors.primaryColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                    child: Text(
                  homeScreenController.tagsList[index].title!,
                  style: Get.textTheme.headlineMedium,
                )),
              ),
            ),
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
      ),
    );
  }

  void chooseCatsBottomSheet(TextTheme textTheme) {
    Get.bottomSheet(
        isScrollControlled: true,
        persistent: true,
        Container(
          height: Get.height / 1.5,
          width: double.infinity,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Text("انتخاب دسته بندی"),
                const SizedBox(
                  height: 8,
                ),
                cats(),
              ],
            ),
          ),
        ));
  }
}
