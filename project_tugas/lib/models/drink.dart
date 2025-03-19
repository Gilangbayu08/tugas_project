// lib/models/drink.dart
class Drink {
  final int? id;
  final String name;
  final double price;

  Drink({
    this.id,
    required this.name,
    required this.price,
  });

  factory Drink.fromMap(Map<String, dynamic> map) {
    return Drink(
      id: map['id'],
      name: map['name'],
      price: map['price'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
    };
  }
}
