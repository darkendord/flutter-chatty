import 'package:flutter/cupertino.dart';

import '../../../models/post_model.dart';

class ArticleView extends StatefulWidget {
  const ArticleView({Key? key, required this.articleModel}) : super(key: key);
  final ArticleModel articleModel;
  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [],
    );
  }
}
