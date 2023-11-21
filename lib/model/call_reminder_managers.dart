class CallReminderManager {
  bool? success;
  String? message;
  List<Data>? data;
  int? statusCode;

  CallReminderManager({this.success, this.message, this.data, this.statusCode});

  CallReminderManager.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status_code'] = this.statusCode;
    return data;
  }
}

class Data {
  int? id;
  String? type;
  String? callManagerName;
  String? mobileNumber;
  String? nextReminderDate;
  String? nextReminderTime, notes;

  Data(
      {this.id,
      this.type,
      this.callManagerName,
      this.mobileNumber,
      this.nextReminderDate,
      this.nextReminderTime,
      this.notes});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    callManagerName = json['call_manager_name'];
    mobileNumber = json['mobile_number'];
    nextReminderDate = json['next_reminder_date'];
    nextReminderTime = json['next_reminder_time'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['call_manager_name'] = this.callManagerName;
    data['mobile_number'] = this.mobileNumber;
    data['next_reminder_date'] = this.nextReminderDate;
    data['next_reminder_time'] = this.nextReminderTime;
    data['notes']=notes;
    return data;
  }
}
