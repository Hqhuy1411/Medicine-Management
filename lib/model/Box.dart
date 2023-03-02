import 'package:app/model/Medicine.dart';

class Box {
  String name;
  var medicines;

  Box({this.name = "", this.medicines});

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
    return Box(name: parsedJson['name'] ?? '', medicines: list);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'medicines': (medicines ?? []).map((e) => e.toJson()).toList()
    };
  }
}
