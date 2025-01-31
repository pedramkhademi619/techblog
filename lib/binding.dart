import 'package:get/get.dart';
import 'package:tech/controller/article/list_article_controller.dart';
import 'package:tech/controller/article/manage_article_controller.dart';
import 'package:tech/controller/register_controller.dart';
import 'package:tech/controller/article/single_article_controller.dart';

class ArticleBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ListArticleController());
    Get.lazyPut(() => SingleArticleController());
  }
}

class ArticleManagerBinding implements Bindings {
  @override
  void dependencies() {
    // Get.put(ManageArticleController());
    Get.lazyPut(() => ManageArticleController());
  }
}

class RegisterBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(RegisterController());
  }
}
