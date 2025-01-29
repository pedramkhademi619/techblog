import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tech/Models/article_model.dart';
import 'package:tech/components/api_constants.dart';
import 'package:tech/services/dio_service.dart';
import 'dart:developer' as developer;

class ManageArticleController extends GetxController {
  RxList<ArticleModel> articleList = RxList.empty();

  @override
  onInit() {
    super.onInit();

    getManageArticle();
  }

  getManageArticle() async {
    articleList.clear();
    //TODO
    // var userId = await GetStorage().read("user_id");
    // developer.log(userId.toString());
    RxBool loading = false.obs;
    var response =
        await DioService().getMethod("${ApiConstants.publishedByMe}2");
    developer.log(response.toString());
    if (response.statusCode == 200) {
      loading.value = true;
      response.data.forEach((element) {
        articleList.add(ArticleModel.fromJson(element));
      });
    }
  }
}
