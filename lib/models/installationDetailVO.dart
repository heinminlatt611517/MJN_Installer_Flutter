import 'dart:convert';

InstallationDetailVo installationDetailVoFromJson(String str) => InstallationDetailVo.fromJson(json.decode(str));

String installationDetailVoToJson(InstallationDetailVo data) => json.encode(data.toJson());

class InstallationDetailVo {
  InstallationDetailVo({
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
  InstallationDetails? details;

  factory InstallationDetailVo.fromJson(Map<String, dynamic> json) => InstallationDetailVo(
    status: json["status"],
    responseCode: json["response_code"],
    description: json["description"],
    isRequieredUpdate: json["is_requiered_update"],
    isforceUpdate: json["isforce_update"],
    updatedStatus: json["updated_status"],
    details:json['details']!=null ? InstallationDetails?.fromJson(json["details"]) : null,
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

class InstallationDetails {
  InstallationDetails({
    this.firstname,
    this.phone1,
    this.subconAssignedDate,
    this.latitude,
    this.longitude,
    this.address,
    this.type,
    this.uid,
    this.installer_id,
    this.user_name,
    this.front_onu_img,
    this.back_onu_img,
    this.before_odb_img,
    this.after_odb_img,
    this.before_spliter_img,
    this.after_spliter_img,
    this.service_acceptance_img,
    this.odb_name,
    this.odb_latitude,
    this.odb_longitude,
    this.gateway_ip,
    this.customer_ip,
    this.network_address,
    this.user_cvlan,
    this.user_svlan,
  });

  String? firstname;
  String? user_name;
  String? phone1;
  String? subconAssignedDate;
  String? latitude;
  String? longitude;
  String? address;
  String? type;
  String? uid;
  String? installer_id;
  String? front_onu_img;
  String? back_onu_img;
  String? before_odb_img;
  String? after_odb_img;
  String? before_spliter_img;
  String? after_spliter_img;
  String? service_acceptance_img;

  String? odb_name;
  String? odb_latitude;
  String? odb_longitude;
  String? gateway_ip;
  String? customer_ip;
  String? network_address;
  String? user_cvlan;
  String? user_svlan;


  factory InstallationDetails.fromJson(Map<String, dynamic> json) => InstallationDetails(
    firstname: json["firstname"],
    phone1: json["phone_1"],
    subconAssignedDate: json["subcon_assigned_date"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    address: json["address"],
    type: json["type"],
    uid: json["uid"],
    installer_id: json["installer_id"],
    user_name: json["user_name"],
    front_onu_img: json["front_onu_img"],
    back_onu_img: json["back_onu_img"],
    before_odb_img: json["before_odb_img"],
    after_odb_img: json["after_odb_img"],
    before_spliter_img: json["before_spliter_img"],
    after_spliter_img: json["after_spliter_img"],
    service_acceptance_img: json["service_acceptance_img"],
    odb_name: json["odb_name"],
    odb_latitude: json["odb_latitude"],
    odb_longitude: json["odb_longitude"],
    gateway_ip: json["gateway_ip"],
    customer_ip: json["customer_ip"],
    network_address: json["network_address"],
    user_cvlan: json["user_cvlan"],
    user_svlan: json["user_svlan"],
  );

  Map<String, dynamic> toJson() => {
    "firstname": firstname,
    "phone_1": phone1,
    "subcon_assigned_date": subconAssignedDate,
    "latitude": latitude,
    "longitude": longitude,
    "address": address,
    "type": type,
    "uid": uid,
    "user_name": user_name,
    "installer_id": installer_id,
    "front_onu_img": front_onu_img,
    "back_onu_img": back_onu_img,
    "before_odb_img": before_odb_img,
    "after_odb_img": after_odb_img,
    "before_spliter_img": before_spliter_img,
    "after_spliter_img": after_spliter_img,
    "service_acceptance_img": service_acceptance_img,
    "odb_name": odb_name,
    "odb_latitude": odb_latitude,
    "odb_longitude": odb_longitude,
    "gateway_ip": gateway_ip,
    "customer_ip": customer_ip,
    "network_address": network_address,
    "user_cvlan": user_cvlan,
    "user_svlan": user_svlan,
  };
}
