class BlogModel {
  final int id;
  final String name;
  final int showInMenu;
  final int showInHome;
  final int position;
  final bool active;

  BlogModel(this.id, this.name, this.showInMenu, this.showInHome, this.position,
      this.active);

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
        json['id'],
        json['name'],
        json.containsKey("show_in_menu") ? int.parse(json['show_in_menu']) : 0,
        json.containsKey("show_in_home") ? int.parse(json['show_in_home']) : 0,
        json['position'] ?? 0,
        json['active'] ?? false);
  }
}
