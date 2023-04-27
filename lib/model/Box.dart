import 'package:app/model/Medicine.dart';

class Box {
  int? id;
  String name;
  var medicines;

  Box({this.id, this.name = "", this.medicines});

  String Info() {
    String result = medicines.map((val) => val.Info()).join(',');
    return 'name : $name' ' Medicines : [ $result ]';
  }

  factory Box.fromJson(Map<String, dynamic> parsedJson) {
    List<Medicine> list = [];
    parsedJson['medicines']?.forEach((val) {
      var data1 = Map<String, dynamic>.from(val as Map);
      list.add(Medicine.fromJson(data1));
    });
    return Box(
        id: parsedJson['id'] ?? 0,
        name: parsedJson['name'] ?? '',
        medicines: list);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'size': medicines.length ?? 0,
      'medicines': (medicines ?? []).map((e) => e.toJson()).toList()
    };
  }

  Medicine? getMedicine() {
    return medicines.length > 0 ? medicines[0] : null;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Box &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          medicines == other.medicines;

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;
}
