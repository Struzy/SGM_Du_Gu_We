class Player {
  Player({
    this.id = '',
    required this.profilePicture,
    required this.name,
    required this.miscellaneous,
  });

  final String id;
  final String profilePicture;
  final String name;
  final String miscellaneous;

  Map<String, dynamic> toJson() => {
    'id': id,
    'profilePicture': profilePicture,
    'name': name,
    'miscellaneous': miscellaneous,
  };

  static Player fromJson(Map<String, dynamic> json) => Player(
    id: json['id'],
    profilePicture: json['profilePicture'],
    name: json['name'],
    miscellaneous: json['miscellaneous'],
  );
}