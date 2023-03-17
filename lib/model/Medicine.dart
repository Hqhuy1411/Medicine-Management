import 'dart:convert';

import 'package:app/model/Usage.dart';
import 'package:http/http.dart' as http;

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
    return 'Name : $name'
            '  description : $description'
            ' quantity : $quantity'
            '\n' +
        usage.Info().toString();
  }

  String Tousage() {
    return 'Morning ' +
        usage.mor.quantity.toString() +
        'Afternoon ' +
        usage.noon.quantity.toString() +
        'Evening ' +
        usage.even.quantity.toString();
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

Future<List<Medicine>> fetchAlbum() async {
  final response = await http
      .get(Uri.parse('https://api.jsonbin.io/v3/b/64141d94c0e7653a05895f00'));

  if (response.statusCode == 200) {
    //return Album.fromJson(jsonDecode(response.body));;
    var list = jsonDecode(response.body);

    List<Medicine> medicines = [];
    for (var i in list['record']) {
      var data = i as Map<String, dynamic>;
      medicines.add(Medicine.fromJson(data));
    }
    return medicines;
  } else {
    throw Exception('Failed to load album');
  }
}
