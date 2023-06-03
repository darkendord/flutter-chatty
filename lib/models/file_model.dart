class FileModel {
  String? cdnId;
  String? cloudId;
  String? ext;
  String? destination;
  String? type;
  int? position;

  FileModel(this.cdnId, this.cloudId, this.ext, this.destination, this.type,
      this.position);

  FileModel.fromJson(Map<String, dynamic> json) {
    cdnId = json['cdn_id'];
    cloudId = json['cloud_id'];
    ext = json['ext'];
    destination = json['destination'];
    type = json['type'];
    position = json['position'];
  }
}
