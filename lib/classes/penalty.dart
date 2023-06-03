class Penalty {
  Penalty({
    required this.profilePicture,
    required this.date,
    required this.surname,
    required this.forename,
    required this.offense,
    required this.amount,
    required this.isPayed,
  });

  String profilePicture;
  String date;
  String surname;
  String forename;
  String offense;
  String amount;
  String isPayed;

  Map<String, dynamic> toJson() => {
        'profilePicture': profilePicture,
        'date': date,
        'surname': surname,
        'forename': forename,
        'offense': offense,
        'amount': amount,
        'isPayed': isPayed,
      };

  static Penalty fromJson(Map<String, dynamic> json) => Penalty(
        profilePicture: json['profilePicture'],
        date: json['date'],
        surname: json['surname'],
        forename: json['forename'],
        offense: json['offense'],
        amount: json['amount'],
        isPayed: json['isPayed'],
      );
}
//(json['date'] as Timestamp).toDate()
