import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tech/Models/article_model.dart';
import 'package:tech/components/constants/api_constants.dart';
import 'package:tech/services/dio_service.dart';

class ListArticleController extends GetxController {
  RxList<ArticleModel> articleList = RxList();

  // TODO GET USER ID FROM GETSTORAGE APICONSTANTS.GETARTICLELIST + USERID
  RxBool loading = false.obs;

  Future<dynamic> getList() async {
    loading.value = true;
    var response = await DioService().getMethod(ApiUrlConstants.getArticleList);
    if (response.statusCode == 200) {
      response.data.forEach((element) {
        articleList.add(ArticleModel.fromJson(element));
        
      });
      loading.value = false;
    }
  }

  Future<dynamic> getArticleListWithTagsId(String id) async {
    articleList.clear();
    loading.value = true;
    var response = await DioService().getMethod(
        "${ApiUrlConstants.baseUrl}article/get.php?command=get_articles_with_tag_id&tag_id=$id&user_id=1");
    if (response.statusCode == 200) {
      response.data.forEach((element) {
        articleList.add(ArticleModel.fromJson(element));
        
      });
      loading.value = false;
    }
  }
}

