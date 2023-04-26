class AccountType {
  int? id;
  String name;
  bool active;
  String uuid;
  DateTime lastUpdate;
  bool syncRelease;

  AccountType({
      this.id,
      required this.name,
      required this.active,
      required this.uuid,
      required this.lastUpdate,
      required this.syncRelease
  });

  @override
  bool operator == (Object other) {
    return other is AccountType && id == (other).id;
  }
}