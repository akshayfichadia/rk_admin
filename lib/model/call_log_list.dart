class CallLogEntryModel {
  final String name;
  final String number;

  CallLogEntryModel({required this.name, required this.number});

  factory CallLogEntryModel.fromJson(Map<String, dynamic> json) {
    return CallLogEntryModel(
      name: json['name'] as String,
      number: json['number'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'number': number,
    };
  }
}
