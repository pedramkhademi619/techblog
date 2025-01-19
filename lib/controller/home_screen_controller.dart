import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tech/Models/article_model.dart';
import 'package:tech/Models/data_models.dart';
import 'package:tech/Models/poster_model.dart';
import 'package:tech/Models/tags_model.dart';
import 'package:tech/components/api_constants.dart';
import 'package:tech/services/dio_service.dart';

class HomeScreenController extends GetxController {
  late Rx<PosterModel> poster;
  late RxList<TagsModel> tagsList = RxList();
  late RxList<ArticleModel> topVisitedList = RxList();
  late RxList<PodCastModel> topPodcastList = RxList();

  @override
  onInit() {
    super.onInit();
    getHomeItems();
  }

  getHomeItems() async {
    var response = await DioService().getMethod(ApiConstants.getHomeItems);
    if (response.statusCode == 200) {
      response.data["top_visited"].forEach((element) {
        topVisitedList.add(ArticleModel.fromJson(element));
      // response.data["top_podcasts"].forEach((element){
      //   topPodcastList.add(PodCastModel.fromJson(element));
      // });
      });
    }
  }
}
