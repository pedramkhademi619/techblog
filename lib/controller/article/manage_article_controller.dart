import 'dart:developer' as developer;

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tech/Models/article_info_model.dart';
import 'package:tech/Models/article_model.dart';
import 'package:tech/Models/tags_model.dart';
import 'package:tech/components/constants/api_constants.dart';
import 'package:tech/components/constants/commands.dart';
import 'package:tech/components/constants/storage_const.dart';
import 'package:tech/controller/file_controller.dart';
import 'package:tech/services/dio_service.dart';

class ManageArticleController extends GetxController {

  @override
  onInit() {
    super.onInit();

    getManageArticle();
  }




  RxList<ArticleModel> articleList = RxList.empty();
  Rx<ArticleInfoModel> articleInfoModel = ArticleInfoModel(
          "اینجا عنوان یه مقاله قرار میگیره، یه عنوان جذاب انتخاب کن.",
          """
من متن و بدنه اصلی مقاله هستم ، اگه میخوای من رو ویرایش کنی و یه مقاله جذاب بنویسی ، نوشته آبی رنگ بالا که نوشته "ویرایش متن اصلی مقاله" رو با انگشتت لمس کن تا وارد ویرایشگر بشی
""",
          "")
      .obs;
  RxList<TagsModel> tagList = RxList.empty();
  RxBool loading = false.obs;
  TextEditingController titleTextEditingController = TextEditingController();

  getManageArticle() async {
    loading.value = true;
    

    var response = await DioService().getMethod(
        "${ApiUrlConstants.publishedByMe}${GetStorage().read(StorageKey.userId)}");

    developer.log(response.toString());
    if (response.statusCode == 200) {
      response.data.forEach((element) {
        articleList.add(ArticleModel.fromJson(element));
      });
      loading.value = false;
    }
  }

  updateTitle() {
    articleInfoModel.update((val) {
      val!.title = titleTextEditingController.text;
    });
  }

  storeArticle() async {
    var fileController = Get.find<FilePickerController>();
    loading.value = true;
    Map<String, dynamic> map = {
      ApiArticleKeyConstants.title: articleInfoModel.value.title,
      ApiArticleKeyConstants.catId: articleInfoModel.value.catId,
      ApiArticleKeyConstants.catName: articleInfoModel.value.catName,
      ApiArticleKeyConstants.image:
          //TODO user didn't select any image
          await dio.MultipartFile.fromFile(fileController.file.value.path!),
      ApiArticleKeyConstants.userId: GetStorage().read(StorageKey.userId),
      ApiArticleKeyConstants.content: articleInfoModel.value.content,
      ApiArticleKeyConstants.command: Commands.store,
      ApiArticleKeyConstants.tagList: "[]",
    };
    var response =
        await DioService().postMethod(map, ApiUrlConstants.postArticle);
    developer.log(response.toString(), name: "response");
    loading.value = false;
  }
}
