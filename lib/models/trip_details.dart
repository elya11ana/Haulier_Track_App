import 'package:flutter/material.dart';

class TruckTrip {
  String task;
  String from;
  String to;
  double distance;
  DateTime date;
  TimeOfDay time;
  String assignTo;
  String truckId;

  TruckTrip({
    required this.task,
    required this.from,
    required this.to,
    required this.distance,
    required this.date,
    required this.time,
    required this.assignTo,
    required this.truckId,
  });
}