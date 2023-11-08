// To parse this JSON data, do
//
//     final historyListEntity = historyListEntityFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

HistoryListEntity historyListEntityFromJson(String str) =>
    HistoryListEntity.fromJson(json.decode(str));

String historyListEntityToJson(HistoryListEntity data) =>
    json.encode(data.toJson());

class HistoryListEntity {
  bool? success;
  String? message;
  List<Datum>? data;
  int? statusCode;

  HistoryListEntity({
    this.success,
    this.message,
    this.data,
    this.statusCode,
  });

  factory HistoryListEntity.fromJson(Map<String, dynamic> json) =>
      HistoryListEntity(
        success: json["success"],
        message: json["message"],
        data: json["data"] == <String, dynamic>{}
            ? []
            : Datum.fromJsonArray(json["data"]),
        statusCode: json["status_code"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "status_code": statusCode,
      };
}

class Datum {
  int? callManagerId;
  String? date;
  String? nextDate;
  String? shortDetails;
  String? ourRemarks;
  String? nextReminderDate;
  String? nextReminderTime;

  Datum({
    this.callManagerId,
    this.date,
    this.nextDate,
    this.shortDetails,
    this.ourRemarks,
    this.nextReminderDate,
    this.nextReminderTime,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        callManagerId: json["call_manager_id"],
        date: json["date"],
        nextDate: json["next_date"],
        shortDetails: json["short_details"],
        ourRemarks: json["our_remarks"],
        nextReminderDate: json["next_reminder_date"],
        nextReminderTime: json["next_reminder_time"],
      );

  static fromJsonArray(dynamic map) {
    print({}.runtimeType);
    List<Datum> list = [];
    if (map.runtimeType == <String, dynamic>{}.runtimeType) {
      return null;
    } else {
      for (var element in map) {
        list.add(Datum.fromJson(element));
      }
    }
    return list;
  }

  Map<String, dynamic> toJson() => {
        "call_manager_id": callManagerId,
        "date": date,
        "next_date": nextDate,
        "short_details": shortDetails,
        "our_remarks": ourRemarks,
        "next_reminder_date": nextReminderDate,
        "next_reminder_time": nextReminderTime,
      };
}
