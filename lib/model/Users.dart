import 'package:app/model/Device.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Users {
  int phone;
  String uid;
  String name;
  List<Device> devices;
  //Medicine devices;
  Users({this.uid = '', this.phone = 0, this.name = '', required this.devices});
  String Info() {
    String result = devices.map((val) => val.Info()).join(',');
    return 'name : $name' ' phone : $phone' ' devices : [ $result ]';
  }

  factory Users.fromJson(Map<String, dynamic> parsedJson) {
    List<Device> list = [];
    parsedJson['devices']?.asMap().forEach((index, val) {
      var data1 = Map<String, dynamic>.from(val as Map);
      Device device = Device.fromJson(data1);
      list.add(device);
    });

    return Users(
        phone: parsedJson['phone'] ?? '',
        name: parsedJson['name'] ?? '',
        devices: list);
  }

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'name': name,
      'devices': devices.map((e) => e.toJson()).toList()
    };
  }
}
