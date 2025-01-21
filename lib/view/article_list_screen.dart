import 'package:flutter/material.dart';
import 'package:tech/components/my_colors.dart';

class ArticleListScreen extends StatelessWidget {
  const ArticleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        actions: const [
          Text("مقالات جدید"),
        ],
        leading: Container(
          height: 40,
          width: 40,
          decoration:  BoxDecoration(
              shape: BoxShape.circle, color: SolidColors.primaryColor.withAlpha(100)),
        ),
      ),
    ));
  }
}
