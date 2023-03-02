import 'package:app/model/Box.dart';
import 'package:app/model/Patient.dart';

class Device {
  String name;
  var patient;
  var boxs;

  Device({this.name = "", this.patient, this.boxs});

  String Info() {
    String result = boxs.map((val) => val.Info()).join(',');
    String pa = patient.Info();
    return 'name:' '$name' 'patient' '$pa' 'Boxs :[$result]';
  }

  factory Device.fromJson(Map<String, dynamic> parsedJson) {
    var data1 = Map<String, dynamic>.from(parsedJson['patient'] as Map);
    List<Box> list = [];
    parsedJson['boxs']?.forEach((val) {
      var data1 = Map<String, dynamic>.from(val as Map);
      list.add(Box.fromJson(data1));
    });
    return Device(
        name: parsedJson['name'] ?? '',
        patient: Patient.fromJson(data1),
        boxs: list);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'patient': patient.toJson(),
      'boxs': (boxs ?? []).map((e) => e.toJson()).toList()
    };
  }
}
