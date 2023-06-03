import 'package:chat_app/models/reaction_model.dart';

import 'blog_model.dart';
import 'bookmark_model.dart';
import 'file_model.dart';
import 'hashtag_model.dart';

class ArticleModel {
  final int id;
  final String title;
  final String publishedAt;
  final String content;
  final BlogModel blog;
  final String? publishEnd;
  final bool showTitle;
  final List<HashtagModel> hashtags;
  final List<FileModel> files;
  final BookmarkModel? bookmark;
  final ReactionModel? myReaction;

  ArticleModel(
    this.id,
    this.title,
    this.content,
    this.publishedAt,
    this.blog,
    this.publishEnd,
    this.showTitle,
    this.hashtags,
    this.files,
    this.bookmark,
    this.myReaction,
  );
  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    final List<HashtagModel> hashtagsList = [];
    final List<FileModel> filesList = [];
    BookmarkModel? myBookmark;
    ReactionModel? myReaction;

    for (var hashtagData in json['hashtags']) {
      hashtagsList.add(HashtagModel.fromJson(hashtagData));
    }

    for (var fileData in json['files']) {
      filesList.add(FileModel.fromJson(fileData));
    }

    if ((json['my_reaction'] as Map<String, dynamic>).isNotEmpty) {
      myReaction = ReactionModel.fromJson({
        ...json['my_reaction'],
        "reference_type": "ARTICLE",
        "reference_type_id": json["id"],
        "id": 0,
        "created_by": 0
      });
    }

    if ((json['bookmark'] as Map<String, dynamic>).isNotEmpty) {
      myBookmark = BookmarkModel.fromJson(json['bookmark']);
    }

    return ArticleModel(
      json['id'],
      json['title'],
      json['content'],
      json['published_at'],
      BlogModel.fromJson(json['blog']),
      json['publish_end'],
      json['show_title'],
      hashtagsList,
      filesList,
      myBookmark,
      myReaction,
    );
  }
}
