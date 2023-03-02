import 'package:app/model/Device.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Users {
  int phone;
  String uid;
  String name;
  var devices;
  //Medicine devices;
  Users({this.uid = '', this.phone = 0, this.name = '', this.devices});
  String Info() {
    String result = devices.map((val) => val.Info()).join(',');
    return 'name : $name' ' phone : $phone' ' devices : [ $result ]';
  }

  factory Users.fromJson(Map<String, dynamic> parsedJson) {
    List<Device> list = [];
    parsedJson['devices']?.forEach((val) {
      var data1 = Map<String, dynamic>.from(val as Map);
      list.add(Device.fromJson(data1));
    });
    list.forEach((element) => print(element.Info()));

    return Users(
        phone: parsedJson['phone'] ?? '',
        name: parsedJson['name'] ?? '',
        devices: list);
  }

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'name': name,
      'devices': (devices ?? []).map((e) => e.toJson()).toList()
    };
  }
}
