import 'package:tech/components/api_constants.dart';

class PodCastModel {
  String? id;
  String? title;
  String? poster;
  String? publisher;
  String? view;
  String? createdAt;

  PodCastModel(
      {required this.id,
      required this.title,
      required this.poster,
      required this.publisher,
      required this.view,
      required this.createdAt});
  PodCastModel.fromJson(Map<String, dynamic> element) {
    id = element["id"];
    title = element["title"];
    poster = ApiConstants.hostDlUrl + element["poster"];
    publisher = element["publisher"];
    view = element["view"];
    createdAt = element["createdAt"];
  }
}
