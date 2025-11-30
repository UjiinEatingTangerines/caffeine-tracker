class CaffeineEntry {
  final String id;
  final String drinkName;
  final double amount; // mg
  final DateTime timestamp;

  CaffeineEntry({
    required this.id,
    required this.drinkName,
    required this.amount,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'drinkName': drinkName,
      'amount': amount,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory CaffeineEntry.fromMap(Map<String, dynamic> map) {
    return CaffeineEntry(
      id: map['id'],
      drinkName: map['drinkName'],
      amount: map['amount'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
}
