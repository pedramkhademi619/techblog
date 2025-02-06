import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tech/Models/article_info_model.dart';
import 'package:tech/Models/article_model.dart';
import 'package:tech/Models/tags_model.dart';
import 'package:tech/components/constants/api_constants.dart';
import 'package:tech/components/constants/storage_const.dart';
import 'package:tech/services/dio_service.dart';
import 'dart:developer' as developer;

class ManageArticleController extends GetxController {
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
  @override
  onInit() {
    super.onInit();

    getManageArticle();
  }

  getManageArticle() async {
    loading.value = true;
    articleList.clear();

    var response = await DioService().getMethod(
        "${ApiConstants.publishedByMe}${GetStorage().read(StorageKey.userId)}");

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
}
