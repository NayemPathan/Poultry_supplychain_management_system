class Business {
  final String id;
  final String name;
  final String ownerId; // Assuming ownerId links to a User
  final String? address;
  final String? contactPhone;

  Business({
    required this.id,
    required this.name,
    required this.ownerId,
    this.address,
    this.contactPhone,
  });

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      id: json['id'],
      name: json['name'],
      ownerId: json['ownerId'],
      address: json['address'],
      contactPhone: json['contactPhone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'ownerId': ownerId,
      'address': address,
      'contactPhone': contactPhone,
    };
  }
}