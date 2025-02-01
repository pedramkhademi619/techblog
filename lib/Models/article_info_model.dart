import 'package:tech/components/constants/api_constants.dart';

class ArticleInfoModel {
  String? id;
  String? title;
  String? content;
  String? image;
  String? author;
  String? catId;
  String? view;
  String? catName;
  String? status;
  String? createdAt;
  bool? isFavorite;

  ArticleInfoModel(
    this.title,
    this.content,
    this.image,
  );

  ArticleInfoModel.fromJson(Map<String, dynamic> element) {
    var info = element["info"];
    id = info['id'];
    title = info['title'];
    content = info['content'];
    image = ApiConstants.hostDlUrl + info['image'];
    author = info['author'];
    catId = info['cat_id'];
    view = info['view'];
    catName = info['cat_name'];
    status = info['status'];
    createdAt = info['created_at'];
    isFavorite = element["isFavorite"];
  }
}
