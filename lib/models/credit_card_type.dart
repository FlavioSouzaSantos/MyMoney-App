class CreditCardType {
  int? id;
  String name;
  bool active;
  String uuid;

  CreditCardType({
    this.id,
    required this.name,
    required this.active,
    required this.uuid
  });
}