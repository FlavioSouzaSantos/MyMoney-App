class Tag {
  int? id;
  String name;
  bool active;
  String uuid;
  String userId;
  DateTime lastUpdate;
  bool syncRelease;

  Tag({
    this.id,
    required this.name,
    required this.active,
    required this.uuid,
    required this.userId,
    required this.lastUpdate,
    required this.syncRelease
  });
}