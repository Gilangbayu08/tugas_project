// lib/models/food.dart
class Food {
  final int? id;
  final String name;
  final double price;

  Food({
    this.id,
    required this.name,
    required this.price,
  });

  factory Food.fromMap(Map<String, dynamic> map) {
    return Food(
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
