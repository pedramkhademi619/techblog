import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech/components/my_components.dart';
import 'package:tech/controller/article/list_article_controller.dart';
import 'package:tech/controller/article/single_article_controller.dart';

class ArticleListScreen extends StatelessWidget {
  ArticleListScreen({super.key, this.title = "مقالات جدید"});

  final ListArticleController listArticleController =
      Get.put(ListArticleController());
  SingleArticleController singleArticleController =
      Get.put(SingleArticleController());
  String? title;
  @override
  Widget build(BuildContext context) {
    var size = Get.size;

    var textTheme = Theme.of(context).textTheme;
    listArticleController.getList();
    return SafeArea(
        child: Scaffold(
            appBar: appBar(title!, context),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                child: Obx(
                  () => ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: listArticleController.articleList.length,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              singleArticleController.getArticleInfo(
                                  listArticleController.articleList[index].id);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CachedNetworkImage(
                                  placeholder: (context, url) => loading(),
                                  errorWidget: (context, url, error) {
                                    return const Icon(
                                      Icons.image_not_supported,
                                      size: 50,
                                      color: Colors.grey,
                                    );
                                  },
                                  imageUrl: listArticleController
                                      .articleList[index].image!,
                                  imageBuilder: (context, imageProvider) {
                                    return Container(
                                      height: size.height / 6,
                                      width: size.width / 3,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(16)),
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover)),
                                    );
                                  },
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: size.width / 2,
                                        child: Text(
                                          listArticleController
                                              .articleList[index].title!,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            listArticleController
                                                .articleList[index].author!,
                                            style: textTheme.bodySmall,
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            "${listArticleController.articleList[index].view!} بازدید",
                                            style: textTheme.bodySmall,
                                          )
                                        ],
                                      )
                                    ])
                              ],
                            ),
                          ),
                        );
                      })),
                ),
              ),
            )));
  }
}
