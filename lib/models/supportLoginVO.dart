import 'dart:convert';

SupportLoginVo supportLoginVoFromJson(String str) =>
    SupportLoginVo.fromJson(json.decode(str));

String supportLoginVoToJson(SupportLoginVo data) => json.encode(data.toJson());

class SupportLoginVo {
  SupportLoginVo({
    required this.status,
    required this.responseCode,
    required this.description,
    required this.token,
    required this.uid,
  });

  String? status;
  String? responseCode;
  String? description;
  String? token;
  String? uid;

  factory SupportLoginVo.fromJson(Map<String, dynamic> json) => SupportLoginVo(
        status: json["status"],
        responseCode: json["response_code"],
        description: json["description"],
        uid: json["uid"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "response_code": responseCode,
        "description": description,
        "uid": uid,
        "token": token,
      };
}
