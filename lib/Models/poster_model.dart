import 'package:tech/components/api_constants.dart';

class PosterModel {
  String? id;
  String? title;
  String? image;

  PosterModel({
    this.id,
    this.title,
    this.image,
  });

  PosterModel.fromJson(Map<String, dynamic> element) {
    id = element["id"];
    title =  element["title"];
    image = ApiConstants.hostDlUrl+ element["image"];
  }
}
