// To parse this JSON data, do
//
//     final networkResultVo = networkResultVoFromJson(jsonString);

import 'dart:convert';

NetworkResultVO networkResultVoFromJson(String str) => NetworkResultVO.fromJson(json.decode(str));

String networkResultVoToJson(NetworkResultVO data) => json.encode(data.toJson());

class NetworkResultVO {
  NetworkResultVO({
    this.status,
    this.responseCode,
    this.description,
    this.isRequieredUpdate,
    this.isforceUpdate,
    this.onuImg,
    this.odbImg,
    this.acceptanceImg,
  });

  String? status;
  String? responseCode;
  String? description;
  bool? isRequieredUpdate;
  bool? isforceUpdate;
  String? onuImg;
  String? odbImg;
  String? acceptanceImg;

  factory NetworkResultVO.fromJson(Map<String, dynamic> json) => NetworkResultVO(
    status: json["status"],
    responseCode: json["response_code"],
    description: json["description"],
    isRequieredUpdate: json["is_requiered_update"],
    isforceUpdate: json["isforce_update"],
    onuImg: json["onu_img"],
    odbImg: json["odb_img"],
    acceptanceImg: json["acceptance_img"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "response_code": responseCode,
    "description": description,
    "is_requiered_update": isRequieredUpdate,
    "isforce_update": isforceUpdate,
    "onu_img": onuImg,
    "odb_img": odbImg,
    "acceptance_img": acceptanceImg,
  };
}