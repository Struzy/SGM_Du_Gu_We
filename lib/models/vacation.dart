class Vacation {
  Vacation({
    this.id = '',
    required this.startDate,
    required this.endDate,
    required this.name,
  });

  final String id;
  final String startDate;
  final String endDate;
  final String name;

  Map<String, dynamic> toJson() => {
    'id': id,
    'startDate': startDate,
    'endDate': endDate,
    'name': name,
  };

  static Vacation fromJson(Map<String, dynamic> json) => Vacation(
    id: json['id'],
    startDate: json['startDate'],
    endDate: json['endDate'],
    name: json['name'],
  );
}
//(json['date'] as Timestamp).toDate()
