// To parse this JSON data, do
//
//     final historyListEntity = historyListEntityFromJson(jsonString);

import 'dart:convert';

HistoryListEntity historyListEntityFromJson(String str) => HistoryListEntity.fromJson(json.decode(str));

String historyListEntityToJson(HistoryListEntity data) => json.encode(data.toJson());

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

  factory HistoryListEntity.fromJson(Map<String, dynamic> json) => HistoryListEntity(
    success: json["success"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
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

  Datum({
    this.callManagerId,
    this.date,
    this.nextDate,
    this.shortDetails,
    this.ourRemarks,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    callManagerId: json["call_manager_id"],
    date: json["date"],
    nextDate: json["next_date"],
    shortDetails: json["short_details"],
    ourRemarks: json["our_remarks"],
  );

  Map<String, dynamic> toJson() => {
    "call_manager_id": callManagerId,
    "date": date,
    "next_date": nextDate,
    "short_details": shortDetails,
    "our_remarks": ourRemarks,
  };
}
