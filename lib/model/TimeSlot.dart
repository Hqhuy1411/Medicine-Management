import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/Notification.dart';

class TimeSlot {
  var time;
  String quantity;

  TimeSlot({this.time = DateTime.now, this.quantity = ""});

  String Info() {
    return 'Quantity : $quantity'
        // +
        //       " " +
        //       DateFormat.jm().format(time).toString() +
        '';
  }

  Map<String, dynamic> toJson() {
    return {
      'time': Timestamp.fromDate(time).seconds,
      'quantity': quantity,
    };
  }

  String getTime() {
    return DateFormat.jm().format(time).toString();
  }

  factory TimeSlot.fromJson(Map<String, dynamic> parsedJson) {
    var data;
    if (parsedJson['time'] == null) {
      data = DateTime.fromMicrosecondsSinceEpoch(1672531200 * 1000);
    } else {
      data = DateTime.fromMillisecondsSinceEpoch(parsedJson['time'] * 1000);
    }
    return TimeSlot(
      time: data,
      quantity: parsedJson['quantity'] ?? '',
    );
  }

  TimeSlot copy({DateTime? time, String? quantity}) => TimeSlot(
        time: time ?? this.time,
        quantity: quantity ?? this.quantity,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeSlot &&
          runtimeType == other.runtimeType &&
          time == other.time &&
          quantity == other.quantity;

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;
}
