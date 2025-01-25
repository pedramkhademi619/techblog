import 'package:tech/components/api_constants.dart';

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

  ArticleInfoModel({
    required this.id,
    required this.title,
    required this.content,
    required this.image,
    required this.author,
    required this.catId,
    required this.view,
    required this.catName,
    required this.status,
    required this.createdAt,
  });

  ArticleInfoModel.fromJson(Map<String, dynamic> element) {
    id = element['id'];
    title = element['title'];
    content = element['content'];
    image = ApiConstants.hostDlUrl + element['image'];
    author = element['author'];
    catId = element['cat_id'];
    view = element['view'];
    catName = element['cat_name'];
    status = element['status'];
    createdAt = element['created_at'];
  }
}
