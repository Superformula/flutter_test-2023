class UserEntity {
  final String id;
  final String name;
  final String profileImageUrl;

  const UserEntity({
    required this.id,
    required this.name,
    required this.profileImageUrl,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserEntity &&
        other.id == id &&
        other.name == name &&
        other.profileImageUrl == profileImageUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ profileImageUrl.hashCode;
  }
}
