class BookmarkModel {
  final bool active;

  BookmarkModel(this.active);

  factory BookmarkModel.fromJson(Map<String, dynamic> json) {
    if (json.isNotEmpty) {
      return BookmarkModel(json['active']);
    }
    return BookmarkModel(false);
  }
}
