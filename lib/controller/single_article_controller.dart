import 'package:get/get.dart';
import 'package:tech/Models/article_info_model.dart';
import 'package:tech/Models/article_model.dart';
import 'package:tech/Models/tags_model.dart';
import 'package:tech/components/api_constants.dart';
import 'package:tech/services/dio_service.dart';
import 'dart:developer' as developer;

class SingleArticleController extends GetxController {
  RxBool loading = false.obs;
  RxString id = "8".obs;
  Rx<ArticleInfoModel> articleInfoModel = ArticleInfoModel().obs;
  RxList<TagsModel> tags = RxList();
  RxList<ArticleModel> related = RxList();

  Future<dynamic> getArticleInfo() async {
    loading.value = true;
    var userId = '';
    developer.log(
        "${ApiConstants.baseUrl}article/get.php?command=info&id=$id&user_id=$userId",
        name: "logging");
    var response = await DioService().getMethod(
        "${ApiConstants.baseUrl}article/get.php?command=info&id=$id&user_id=$userId");
    print(response.data);
    if (response.statusCode == 200) {
      articleInfoModel.value = ArticleInfoModel.fromJson(response.data);

      response.data["tags"].forEach((element) {
        tags.add(TagsModel.fromJson(element));
      });
      response.data["related"].forEach((element) {
        related.add(ArticleModel.fromJson(element));
      });

      loading.value = false;
    }
  }
}
