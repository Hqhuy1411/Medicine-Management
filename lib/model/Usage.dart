import 'package:flutter/material.dart';

class Usage {
  int mor;
  int noon;
  int even;
  Usage({this.mor = 0, this.noon = 0, this.even = 0});
  String Info() {
    return 'Sang : $mor'
        '  Trua : $noon'
        ' Toi : $even';
  }

  int Total() {
    return mor + even + noon;
  }

  factory Usage.fromJson(Map<String, dynamic> parsedJson) {
    return Usage(
      mor: parsedJson['Sang'] ?? 0,
      noon: parsedJson['Trua'] ?? 0,
      even: parsedJson['Toi'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Sang': mor,
      'Trua': noon,
      'Toi': even,
    };
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
