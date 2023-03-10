import 'package:flutter/material.dart';

import 'TimeSlot.dart';

class Usage {
  TimeSlot mor;
  TimeSlot noon;
  TimeSlot even;
  Usage({required this.mor, required this.noon, required this.even});
  String Info() {
    return 'Sang :' +
        mor.Info() +
        'Trua :' +
        noon.Info() +
        'Toi :' +
        even.Info();
  }

  int Total() {
    return mor.quantity + even.quantity + noon.quantity;
  }

  factory Usage.fromJson(Map<String, dynamic> parsedJson) {
    // parsedJson.forEach((key, value) {
    //   print('$key' ' :' '$value');
    // });
    return Usage(
      mor: TimeSlot.fromJson(
          Map<String, dynamic>.from(parsedJson['Sang'] as Map)),
      noon: TimeSlot.fromJson(
          Map<String, dynamic>.from(parsedJson['Trua'] as Map)),
      even: TimeSlot.fromJson(
          Map<String, dynamic>.from(parsedJson['Toi'] as Map)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Sang': mor.toJson(),
      'Trua': noon.toJson(),
      'Toi': even.toJson(),
    };
  }

  Usage copy({TimeSlot? mor, TimeSlot? noon, TimeSlot? even}) => Usage(
        mor: mor ?? this.mor,
        noon: noon ?? this.noon,
        even: even ?? this.even,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Usage &&
          runtimeType == other.runtimeType &&
          mor == other.mor &&
          noon == other.noon &&
          even == other.even;

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;
}
