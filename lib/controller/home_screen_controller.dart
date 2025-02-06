import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tech/Models/article_model.dart';
import 'package:tech/Models/pod_cast_model.dart';
import 'package:tech/Models/poster_model.dart';
import 'package:tech/Models/tags_model.dart';
import 'package:tech/components/constants/api_constants.dart';
import 'package:tech/services/dio_service.dart';

class HomeScreenController extends GetxController {
  Rx<PosterModel> poster = PosterModel().obs;
  RxList<TagsModel> tagsList = RxList();
  RxList<ArticleModel> topVisitedList = RxList();
  RxList<PodCastModel> topPodcastList = RxList();
  RxBool loading = false.obs;

  @override
  onInit() {
    super.onInit();
    getHomeItems();
  }

  getHomeItems() async {
    
    loading.value = true;
    var response = await DioService().getMethod(ApiConstants.getHomeItems);
    if (response.statusCode == 200) {
      response.data["top_visited"].forEach((element) {
        topVisitedList.add(ArticleModel.fromJson(element));
        response.data["top_podcasts"].forEach((element) {
          topPodcastList.add(PodCastModel.fromJson(element));
        });
      });
      tagsList.clear();
      response.data["tags"].forEach((element) {
        tagsList.add(TagsModel.fromJson(element));
      });

      poster.value = PosterModel.fromJson(response.data["poster"]);
      loading.value = false;
    }
  }
}
