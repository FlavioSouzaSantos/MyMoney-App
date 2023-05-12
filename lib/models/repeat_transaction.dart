class RepeatTransaction {
  int count;
  RepeatTransactionType type;

  RepeatTransaction({
    required this.count,
    required this.type
  });
}

enum RepeatTransactionType {
  month,
  day,
  week,
  year
}