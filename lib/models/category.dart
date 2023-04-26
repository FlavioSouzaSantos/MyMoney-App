class Category {
  final int? id;
  final String name;
  final Category? parent;
  final int? parentId;
  final bool active;
  final String uuid;
  final String userId;
  final DateTime lastUpdate;
  final bool syncRelease;

  const Category({
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