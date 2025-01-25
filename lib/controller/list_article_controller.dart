import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tech/Models/article_model.dart';
import 'package:tech/components/api_constants.dart';
import 'package:tech/services/dio_service.dart';

class ListArticleController extends GetxController {
  RxList<ArticleModel> articleList = RxList();

  

  // TODO GET USER ID FROM GETSTORAGE APICONSTANTS.GETARTICLELIST + USERID
  RxBool loading = false.obs;

  Future<dynamic> getList() async {
    loading.value = true;
    var response = await DioService().getMethod(ApiConstants.getArticleList);
    if (response.statusCode == 200) {
      response.data.forEach((element) {
        articleList.add(ArticleModel.fromJson(element));
        loading.value = false;
      });
    }
  }
}
