class HashtagModel {
  final int id;
  final String value;

  HashtagModel(this.id, this.value);

  factory HashtagModel.fromJson(Map<String, dynamic> json) {
    return HashtagModel(json['id'], json['value']);
  }
}
