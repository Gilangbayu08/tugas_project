class User {
  final int? id;
  final String fullName;
  final String username;
  final String birthDate;
  final String gender;
  final String password;
  final String address;

  User({
    this.id,
    required this.fullName,
    required this.username,
    required this.birthDate,
    required this.gender,
    required this.password,
    required this.address,
  });

  // Mengonversi User ke Map untuk disimpan di database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'username': username,
      'birthDate': birthDate,
      'gender': gender,
      'password': password,
      'address': address,
    };
  }

  // Membuat User dari Map (misalnya dari database)
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      fullName: map['fullName'],
      username: map['username'],
      birthDate: map['birthDate'],
      gender: map['gender'],
      password: map['password'],
      address: map['address'],
    );
  }
}
