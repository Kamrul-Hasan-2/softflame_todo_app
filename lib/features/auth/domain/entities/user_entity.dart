class UserEntity {
  final String id;
  final String phoneNumber;
  final String? name;
  final String? email;
  final DateTime? createdAt;

  const UserEntity({
    required this.id,
    required this.phoneNumber,
    this.name,
    this.email,
    this.createdAt,
  });

  UserEntity copyWith({
    String? id,
    String? phoneNumber,
    String? name,
    String? email,
    DateTime? createdAt,
  }) {
    return UserEntity(
      id: id ?? this.id,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      name: name ?? this.name,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
