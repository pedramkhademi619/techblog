import 'package:tech/components/constants/api_constants.dart';

class PodCastModel {
  String? id;
  String? title;
  String? poster;
  String? publisher;
  String? view;
  String? createdAt;

  PodCastModel(
      {this.id,
      this.title,
      this.poster,
      this.publisher,
      this.view,
      this.createdAt});
  PodCastModel.fromJson(Map<String, dynamic> element) {
    id = element["id"];
    title = element["title"];
    poster = ApiUrlConstants.hostDlUrl + element["poster"];
    publisher = element["author"];
    view = element["view"];
    createdAt = element["createdAt"];
  }
}


