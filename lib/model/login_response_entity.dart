// To parse this JSON data, do
//
//     final loginEntity = loginEntityFromJson(jsonString);

import 'dart:convert';

LoginEntity loginEntityFromJson(String str) =>
    LoginEntity.fromJson(json.decode(str));

String loginEntityToJson(LoginEntity data) => json.encode(data.toJson());

class LoginEntity {
  bool? success;
  String? message;
  Data? data;

  LoginEntity({
    this.success,
    this.message,
    this.data,
  });

  factory LoginEntity.fromJson(Map<String, dynamic> json) => LoginEntity(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  int? id;
  String? name;
  String? email;
  dynamic birthDate;
  dynamic companyName;
  dynamic profileImage;
  dynamic mobileNumber;
  dynamic gstNo;
  dynamic tanNo;
  dynamic panNo;
  dynamic sanadNo;
  dynamic agrmentsAndPaymentConditions;
  dynamic address;
  dynamic remarks;
  dynamic noticeBoard;
  dynamic businessCategoryId;
  dynamic emailVerifiedAt;
  int? isAdmin;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? token;

  Data({
    this.id,
    this.name,
    this.email,
    this.birthDate,
    this.companyName,
    this.profileImage,
    this.mobileNumber,
    this.gstNo,
    this.tanNo,
    this.panNo,
    this.sanadNo,
    this.agrmentsAndPaymentConditions,
    this.address,
    this.remarks,
    this.noticeBoard,
    this.businessCategoryId,
    this.emailVerifiedAt,
    this.isAdmin,
    this.createdAt,
    this.updatedAt,
    this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        birthDate: json["birth_date"],
        companyName: json["company_name"],
        profileImage: json["profile_image"],
        mobileNumber: json["mobile_number"],
        gstNo: json["gst_no"],
        tanNo: json["tan_no"],
        panNo: json["pan_no"],
        sanadNo: json["sanad_no"],
        agrmentsAndPaymentConditions: json["agrments_and_payment_conditions"],
        address: json["address"],
        remarks: json["remarks"],
        noticeBoard: json["notice_board"],
        businessCategoryId: json["business_category_id"],
        emailVerifiedAt: json["email_verified_at"],
        isAdmin: json["is_admin"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "birth_date": birthDate,
        "company_name": companyName,
        "profile_image": profileImage,
        "mobile_number": mobileNumber,
        "gst_no": gstNo,
        "tan_no": tanNo,
        "pan_no": panNo,
        "sanad_no": sanadNo,
        "agrments_and_payment_conditions": agrmentsAndPaymentConditions,
        "address": address,
        "remarks": remarks,
        "notice_board": noticeBoard,
        "business_category_id": businessCategoryId,
        "email_verified_at": emailVerifiedAt,
        "is_admin": isAdmin,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "token": token,
      };
}
