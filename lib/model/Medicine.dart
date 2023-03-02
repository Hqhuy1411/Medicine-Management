import 'package:app/model/Usage.dart';

class Medicine {
  String name;
  String description;
  int quantity;
  Usage usage;
  Medicine(
      {this.name = '',
      this.description = '',
      this.quantity = 0,
      required this.usage});
  String Info() {
    return 'name : $name'
            '  description : $description'
            ' quantity : $quantity'
            ' usage :' +
        usage.Info().toString();
  }

  factory Medicine.fromJson(Map<String, dynamic> parsedJson) {
    var data1 = Map<String, dynamic>.from(parsedJson['usage'] as Map);
//print('usage' '$data1');
    return Medicine(
        quantity: parsedJson['quantity'] ?? 0,
        description: parsedJson['description'] ?? '',
        name: parsedJson['name'] ?? '',
        usage: Usage.fromJson(data1));
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'quantity': quantity,
      'name': name,
      'usage': usage.toJson()
    };
  }

  Medicine copy(
          {String? name, String? description, int? quantity, Usage? usage}) =>
      Medicine(
          name: name ?? this.name,
          description: description ?? this.description,
          quantity: quantity ?? this.quantity,
          usage: usage ?? this.usage);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Medicine &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          description == other.description &&
          quantity == other.quantity &&
          usage == other.usage;

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;
}
