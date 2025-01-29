import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tech/Models/article_info_model.dart';
import 'package:tech/Models/article_model.dart';
import 'package:tech/Models/tags_model.dart';
import 'package:tech/components/api_constants.dart';
import 'package:tech/components/storage_const.dart';
import 'package:tech/main.dart';
import 'package:tech/services/dio_service.dart';
import 'package:tech/view/register/register_intro.dart';
import 'dart:developer' as developer;
import '../../view/article/single.dart' ;

class SingleArticleController extends GetxController {
  RxBool loading = false.obs;
  
  Rx<ArticleInfoModel> articleInfoModel = ArticleInfoModel().obs;
  RxList<TagsModel> tags = RxList();
  RxList<ArticleModel> related = RxList();

  Future<dynamic> getArticleInfo(var id) async {
    articleInfoModel = ArticleInfoModel().obs; 
    //خط بالا برای اینه که وقتی میریم تو یه صفحه ای دیتای صفحه قبلی  نمایش داده نشه
    //مثل همون clear کردن لیسته
    loading.value = true;
    var userId = '';

    var response = await DioService().getMethod(
        "${ApiConstants.baseUrl}article/get.php?command=info&id=$id&user_id=$userId");
    if (response.statusCode == 200) {
      articleInfoModel.value = ArticleInfoModel.fromJson(response.data);

tags.clear();
      response.data["tags"].forEach((element) {
        tags.add(TagsModel.fromJson(element));
      });
      related.clear();
      response.data["related"].forEach((element) {
        related.add(ArticleModel.fromJson(element));
      });

      loading.value = false;
    }
      Get.toNamed(NamedRoute.routeSingleArticle);

  }



}
