// To parse this JSON data, do
//
//     final callListEntity = callListEntityFromJson(jsonString);

import 'dart:convert';

CallListEntity callListEntityFromJson(String str) =>
    CallListEntity.fromJson(json.decode(str));

String callListEntityToJson(CallListEntity data) => json.encode(data.toJson());

class CallListEntity {
  bool? success;
  String? message;
  List<Datum>? data;
  int? statusCode;

  CallListEntity({
    this.success,
    this.message,
    this.data,
    this.statusCode,
  });

  factory CallListEntity.fromJson(Map<String, dynamic> json) => CallListEntity(
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
  int? id;
  int? no;
  String? date;
  String? receivedBy;
  String? shortOrder;
  CallFor? callFor;
  String? name;
  String? companyName;
  String? city;
  String? mobileNo;
  String? referanceBy;
  String? shortBrief;
  String? ourRemarks;
  ManagerStatus? managerStatus;
  String? createdBy;
  String? nextReminderDate;
  String? nextReminderTime;

  Datum({
    this.id,
    this.no,
    this.date,
    this.receivedBy,
    this.shortOrder,
    this.callFor,
    this.name,
    this.companyName,
    this.city,
    this.mobileNo,
    this.referanceBy,
    this.shortBrief,
    this.ourRemarks,
    this.managerStatus,
    this.createdBy,
    this.nextReminderDate,
    this.nextReminderTime,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        no: json["no"],
        date: json["date"],
        receivedBy: json["received_by"],
        shortOrder: json["short_order"],
        callFor: callForValues.map[json["call_for"]],
        name: json["name"],
        companyName: json["company_name"],
        city: json["city"],
        mobileNo: json["mobile_no"],
        referanceBy: json["referance_by"],
        shortBrief: json["short_brief"],
        ourRemarks: json["our_remarks"],
        managerStatus: managerStatusValues.map[json["manager_status"]],
        createdBy: json["created by"],
        nextReminderDate: json["next_reminder_date"],
        nextReminderTime: json["next_reminder_time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "no": no,
        "date": date,
        "received_by": receivedBy,
        "short_order": shortOrder,
        "call_for": callForValues.reverse[callFor],
        "name": name,
        "company_name": companyName,
        "city": city,
        "mobile_no": mobileNo,
        "referance_by": referanceBy,
        "short_brief": shortBrief,
        "our_remarks": ourRemarks,
        "manager_status": managerStatusValues.reverse[managerStatus],
        "created by": createdBy,
        "next_reminder_date": nextReminderDate,
        "next_reminder_time": nextReminderTime,
      };
}

enum CallFor {
  EMPTY,
  RUNNING_CASE_RELATED_CALL,
  FIRST_TIME_NEW_CASE_INQUIRY,
  REPEAT_CALL_FOR_NEW_CASE_INQUIRY,
  APPOINTMENT_RELATED_CALL,
  FORMAL_CALL,
  OTHERS,
}

final callForValues = EnumValues({
  "": CallFor.EMPTY,
  "Running Case Related Call": CallFor.RUNNING_CASE_RELATED_CALL,
  "First Time New Case Inquiry": CallFor.FIRST_TIME_NEW_CASE_INQUIRY,
  "Repeat Call For New Case Inquiry": CallFor.REPEAT_CALL_FOR_NEW_CASE_INQUIRY,
  "Appointment Related Call": CallFor.APPOINTMENT_RELATED_CALL,
  "Formal Call": CallFor.FORMAL_CALL,
  "Others": CallFor.OTHERS,
});

enum ManagerStatus { EMPTY, PENDING, RUNNING, COMPLETED }

final managerStatusValues = EnumValues({
  "": ManagerStatus.EMPTY,
  "pending": ManagerStatus.PENDING,
  "running": ManagerStatus.RUNNING,
  "completed": ManagerStatus.COMPLETED
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
