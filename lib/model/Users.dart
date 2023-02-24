import 'package:app/model/Medicine.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Users {
  int phone;
  String uid;
  String name;
  var medicines;
  //Medicine medicines;
  Users({this.uid = '', this.phone = 0, this.name = '', this.medicines});
  String Info() {
    String result = medicines.map((val) => val.Info()).join(',');
    return 'name : $name' ' phone : $phone' ' Medicines : [ $result ]';
  }

  factory Users.fromJson(Map<String, dynamic> parsedJson) {
    List<Medicine> list = [];
    parsedJson['medicines']?.forEach((val) {
      var data1 = Map<String, dynamic>.from(val as Map);
      list.add(Medicine.fromJson(data1));
    });
    return Users(
        phone: parsedJson['phone'] ?? '',
        name: parsedJson['name'] ?? '',
        medicines: list);
  }

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'name': name,
      'medicines': (medicines ?? []).map((e) => e.toJson()).toList()
    };
  }
}
