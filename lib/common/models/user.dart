class User {
  final String id;
  final String name;
  final String phone;
  final String role;
  final String? address; // Optional for some roles

  User({
    required this.id,
    required this.name,
    required this.phone,
    required this.role,
    this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      role: json['role'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'role': role,
      'address': address,
    };
  }
}