class UserProfile {
  UserProfile({
    this.id = '',
    required this.profilePicture,
    required this.name,
    required this.email,
  });

  final String id;
  final String profilePicture;
  final String name;
  final String email;

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'profilePicture': profilePicture,
        'name': name,
        'email': email,
      };

  static UserProfile fromJson(Map<String, dynamic> json) =>
      UserProfile(
        id: json['id'],
        profilePicture: json['profilePicture'],
        name: json['name'],
        email: json['email'],
      );
}
