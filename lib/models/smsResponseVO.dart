// To parse this JSON data, do
//
//     final smsResponseVo = smsResponseVoFromJson(jsonString);

import 'dart:convert';

SmsResponseVo smsResponseVoFromJson(String str) => SmsResponseVo.fromJson(json.decode(str));

String smsResponseVoToJson(SmsResponseVo data) => json.encode(data.toJson());

class SmsResponseVo {
  SmsResponseVo({
    this.status,
    this.responseCode,
    this.description,
    this.isRequieredUpdate,
    this.isforceUpdate,
    this.details,
  });

  String? status;
  String? responseCode;
  String? description;
  bool? isRequieredUpdate;
  bool? isforceUpdate;
  String? details;

  factory SmsResponseVo.fromJson(Map<String, dynamic> json) => SmsResponseVo(
    status: json["status"],
    responseCode: json["response_code"],
    description: json["description"],
    isRequieredUpdate: json["is_requiered_update"],
    isforceUpdate: json["isforce_update"],
    details: json["details"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "response_code": responseCode,
    "description": description,
    "is_requiered_update": isRequieredUpdate,
    "isforce_update": isforceUpdate,
    "details": details,
  };
}
