import 'package:flutter/material.dart';

import 'TimeSlot.dart';

class Usage {
  TimeSlot mor;
  TimeSlot noon;
  TimeSlot even;
  Usage({required this.mor, required this.noon, required this.even});
  String Info() {
    return 'S :' + mor.Info() + ' C :' + noon.Info() + ' T :' + even.Info();
  }

  String Total() {
    return mor.quantity + even.quantity + noon.quantity;
  }

  int checkEmpty() {
    if (mor.quantity != "0" && noon.quantity != "0" && even.quantity != "0") {
      return 1;
    } else if (mor.quantity != "0" &&
        noon.quantity != "0" &&
        even.quantity == "0") {
      return 2;
    } else if (mor.quantity != "0" &&
        noon.quantity == "0" &&
        even.quantity != "0") {
      return 3;
    } else if (mor.quantity == "0" &&
        noon.quantity != "0" &&
        even.quantity != "0") {
      return 4;
    } else {
      return 0;
    }
  }

  factory Usage.fromJson(Map<String, dynamic> parsedJson) {
    // parsedJson.forEach((key, value) {
    //   print('$key' ' :' '$value');
    // });
    return Usage(
      mor: TimeSlot.fromJson(
          Map<String, dynamic>.from(parsedJson['Morning'] as Map)),
      noon: TimeSlot.fromJson(
          Map<String, dynamic>.from(parsedJson['Afternoon'] as Map)),
      even: TimeSlot.fromJson(
          Map<String, dynamic>.from(parsedJson['Evening'] as Map)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Morning': mor.toJson(),
      'Afternoon': noon.toJson(),
      'Evening': even.toJson(),
    };
  }

  Usage copy({TimeSlot? mor, TimeSlot? noon, TimeSlot? even}) => Usage(
        mor: mor ?? this.mor,
        noon: noon ?? this.noon,
        even: even ?? this.even,
      );

  bool ss(Usage usage) {
    return mor.time == usage.mor.time &&
        noon.time == usage.noon.time &&
        even.time == usage.even.time;
  }

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
