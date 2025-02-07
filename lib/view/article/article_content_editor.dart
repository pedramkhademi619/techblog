import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:tech/controller/article/manage_article_controller.dart';
import 'dart:developer' as developer;
import '../../components/my_components.dart';

class ArticleContentEditor extends StatelessWidget {
  ArticleContentEditor({super.key});

  final HtmlEditorController controller = HtmlEditorController();
  final ManageArticleController manageArticleController =
      Get.put(ManageArticleController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.clearFocus();
      },
      child: Scaffold(
        appBar: appBar("نوشتن/ویرایش مقاله", context),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HtmlEditor(
                controller: controller,
                htmlEditorOptions: HtmlEditorOptions(
                    hint: "میتونی مقاله تو اینجا بنویسی...",
                    initialText:
                        manageArticleController.articleInfoModel.value.content,
                    shouldEnsureVisible: true),
                callbacks: Callbacks(
                  onChangeContent: ((p0) {
                    manageArticleController.articleInfoModel.update((value) {
                      value!.content = p0;
                    });
                    developer.log(p0!);
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
