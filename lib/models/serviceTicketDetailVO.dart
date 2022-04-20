import 'dart:convert';

ServiceTicketDetailVo serviceTicketDetailVoFromJson(String str) => ServiceTicketDetailVo.fromJson(json.decode(str));

String serviceTicketDetailVoToJson(ServiceTicketDetailVo data) => json.encode(data.toJson());

class ServiceTicketDetailVo {
  ServiceTicketDetailVo({
    this.status,
    this.responseCode,
    this.description,
    this.isRequieredUpdate,
    this.isforceUpdate,
    this.updatedStatus,
    this.details,
  });

  String? status;
  String? responseCode;
  String? description;
  bool? isRequieredUpdate;
  bool? isforceUpdate;
  String? updatedStatus;
  ServiceTicketDetails? details;

  factory ServiceTicketDetailVo.fromJson(Map<String, dynamic> json) => ServiceTicketDetailVo(
    status: json["status"],
    responseCode: json["response_code"],
    description: json["description"],
    isRequieredUpdate: json["is_requiered_update"],
    isforceUpdate: json["isforce_update"],
    updatedStatus: json["updated_status"],
    details:json['details']!=null ? ServiceTicketDetails?.fromJson(json["details"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "response_code": responseCode,
    "description": description,
    "is_requiered_update": isRequieredUpdate,
    "isforce_update": isforceUpdate,
    "updated_status": updatedStatus,
    "details": details!.toJson(),
  };
}

class ServiceTicketDetails {
  ServiceTicketDetails({
    this.subconAssignedDate,
    this.latitude,
    this.longitude,
    this.address,
    this.userName,
    this.firstname,
    this.profileID,
    this.phone1,
    this.topic,
    this.type,
    this.installerId,
    this.message
  });

  String? subconAssignedDate;
  String? latitude;
  String? longitude;
  String? address;
  String? userName;
  String? firstname;
  String? profileID;
  String? phone1;
  String? topic;
  String? type;
  String? installerId;
  String? message;

  factory ServiceTicketDetails.fromJson(Map<String, dynamic> json) => ServiceTicketDetails(
    subconAssignedDate: json["subcon_assigned_date"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    address: json["address"],
    userName: json["user_name"],
    firstname: json["firstname"],
    profileID: json["profile_id"],
    phone1: json["phone_1"],
    topic: json["topic"],
    type: json["type"],
    installerId: json["installer_id"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "subcon_assigned_date": subconAssignedDate,
    "latitude": latitude,
    "longitude": longitude,
    "address": address,
    "user_name": userName,
    "firstname": firstname,
    "profile_id": profileID,
    "phone_1": phone1,
    "topic": topic,
    "type": type,
    "installer_id": installerId,
    "message": message,
  };
}
