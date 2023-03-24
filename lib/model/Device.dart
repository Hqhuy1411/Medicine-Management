import 'package:app/model/Box.dart';
import 'package:app/model/Patient.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Device {
  int? id;
  String description;
  var patient;
  var boxs;

  Device({this.id, this.description = "", this.patient, this.boxs}) {
    if (boxs.length == 0) {
      for (int i = 1; i <= 5; i++) {
        boxs.add(Box(id: i, name: "Box ${i}", medicines: []));
      }
    }
  }

  String Info() {
    String result = "";
    if (boxs != null) {
      result = boxs.map((val) => val.Info()).join(',');
    }
    String pa = patient.Info();
    return 'id:' '$id' 'patient' '$pa' 'Boxs :[$result]';
  }

  factory Device.fromJson(Map<String, dynamic> parsedJson) {
    var data1 = Map<String, dynamic>.from(parsedJson['patient'] as Map);
    List<Box> list = [];
    parsedJson['boxs']?.forEach((val) {
      var data1 = Map<String, dynamic>.from(val as Map);
      list.add(Box.fromJson(data1));
    });
    return Device(
        id: parsedJson['id'] ?? 0,
        description: parsedJson['description'] ?? '',
        patient: Patient.fromJson(data1),
        boxs: list);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'patient': patient.toJson(),
      'boxs': (boxs ?? []).map((e) => e.toJson()).toList()
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Device &&
          runtimeType == other.runtimeType &&
          description == other.description &&
          id == other.id &&
          patient == other.patient &&
          boxs == other.boxs;

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;
}
