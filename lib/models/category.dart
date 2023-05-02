class Category {
  int? id;
  String name;
  Category? parent;
  int? parentId;
  bool active;
  String uuid;
  String userId;
  DateTime lastUpdate;
  bool syncRelease;

  Category({
    this.id,
    required this.name,
    this.parent,
    this.parentId,
    required this.active,
    required this.uuid,
    required this.userId,
    required this.lastUpdate,
    required this.syncRelease
  });
}