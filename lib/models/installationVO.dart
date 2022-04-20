import 'dart:convert';

InstallationVo installationVoFromJson(String str) =>
    InstallationVo.fromJson(json.decode(str));

String installationVoToJson(InstallationVo data) => json.encode(data.toJson());

class InstallationVo {
  InstallationVo({
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
  List<InstallationDetail>? details;

  factory InstallationVo.fromJson(Map<String, dynamic> json) => InstallationVo(
        status: json["status"],
        responseCode: json["response_code"],
        description: json["description"],
        isRequieredUpdate: json["is_requiered_update"],
        isforceUpdate: json["isforce_update"],
        updatedStatus: json["updated_status"],
        details: List<InstallationDetail>.from(
            json["details"]?.map((x) => InstallationDetail.fromJson(x)) ?? []),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "response_code": responseCode,
        "description": description,
        "is_requiered_update": isRequieredUpdate,
        "isforce_update": isforceUpdate,
        "updated_status": updatedStatus,
        "details": List<dynamic>.from(details!.map((x) => x.toJson())),
      };
}

class InstallationDetail {
  InstallationDetail(
      {this.profileId,
      this.firstname,
      this.phone1,
      this.township,
      this.uid,
      this.status,
      this.subcon_assigned_date,
        this.status_txt,
      this.plan});

  String? township;
  String? profileId;
  String? firstname;
  String? phone1;
  String? uid;
  String? status;
  String? subcon_assigned_date;
  String? plan;
  String? status_txt;

  factory InstallationDetail.fromJson(Map<String, dynamic> json) =>
      InstallationDetail(
          profileId: json["profile_id"],
          firstname: json["firstname"],
          phone1: json["phone_1"],
          township: json["township"],
          uid: json["uid"],
          status: json["status"],
          plan: json["plan"],
          status_txt: json["status_txt"],
          subcon_assigned_date: json['subcon_assigned_date']);

  Map<String, dynamic> toJson() => {
        "profile_id": profileId,
        "firstname": firstname,
        "phone_1": phone1,
        "township": township,
        "uid": uid,
        "status": status,
        "subcon_assigned_date": subcon_assigned_date,
        "plan" : plan,
        "status_txt" : status_txt,
      };
}
