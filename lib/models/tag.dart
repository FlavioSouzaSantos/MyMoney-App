class Tag {
  final int? id;
  final String name;
  final bool active;
  final String uuid;
  final String userId;
  final DateTime lastUpdate;
  final bool syncRelease;

  const Tag({
    this.id,
    required this.name,
    required this.active,
    required this.uuid,
    required this.userId,
    required this.lastUpdate,
    required this.syncRelease
  });
}