import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeSlot {
  var time;
  int quantity;

  TimeSlot({this.time = DateTime.now, this.quantity = 0});

  String Info() {
    return '{Quantity : $quantity' +
        DateFormat.jm().format(time).toString() +
        '}';
  }

  Map<String, dynamic> toJson() {
    return {
      'time': Timestamp.fromDate(time).seconds,
      'quantity': quantity,
    };
  }

  factory TimeSlot.fromJson(Map<String, dynamic> parsedJson) {
    return TimeSlot(
      time: DateTime.fromMillisecondsSinceEpoch(parsedJson['time'] * 1000),
      quantity: parsedJson['quantity'] ?? 0,
    );
  }

  TimeSlot copy({DateTime? time, int? quantity}) => TimeSlot(
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
