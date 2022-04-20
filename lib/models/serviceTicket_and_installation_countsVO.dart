import 'dart:convert';

ServiceTicketAdnInstallationCountsVO serviceTicketAdnInstallationCountsFromJson(String str) => ServiceTicketAdnInstallationCountsVO.fromJson(json.decode(str));

String serviceTicketAdnInstallationCountsToJson(ServiceTicketAdnInstallationCountsVO data) => json.encode(data.toJson());

class ServiceTicketAdnInstallationCountsVO {
  ServiceTicketAdnInstallationCountsVO({
    this.status,
    this.responseCode,
    this.description,
    this.isRequieredUpdate,
    this.isforceUpdate,
    this.updatedStatus,
    this.allInstallationCounts,
    this.newInstallationCount,
    this.pendingInstallationCount,
    this.completedInstallationCount,
    this.allServiceTicketsCounts,
    this.newOrderCount,
    this.pendingCount,
    this.completedCount,
  });

  String? status;
  String? responseCode;
  String? description;
  bool? isRequieredUpdate;
  bool? isforceUpdate;
  String? updatedStatus;
  int? allInstallationCounts;
  int? newInstallationCount;
  int? pendingInstallationCount;
  int? completedInstallationCount;
  int? allServiceTicketsCounts;
  int? newOrderCount;
  int? pendingCount;
  int? completedCount;

  factory ServiceTicketAdnInstallationCountsVO.fromJson(Map<String, dynamic> json) => ServiceTicketAdnInstallationCountsVO(
    status: json["status"],
    responseCode: json["response_code"],
    description: json["description"],
    isRequieredUpdate: json["is_requiered_update"],
    isforceUpdate: json["isforce_update"],
    updatedStatus: json["updated_status"],
    allInstallationCounts: json["all_installation_counts"],
    newInstallationCount: json["new_installation_count"],
    pendingInstallationCount: json["pending_installation_count"],
    completedInstallationCount: json["completed_installation_count"],
    allServiceTicketsCounts: json["all_service_tickets_counts"],
    newOrderCount: json["new_order_count"],
    pendingCount: json["pending_count"],
    completedCount: json["completed_count"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "response_code": responseCode,
    "description": description,
    "is_requiered_update": isRequieredUpdate,
    "isforce_update": isforceUpdate,
    "updated_status": updatedStatus,
    "all_installation_counts": allInstallationCounts,
    "new_installation_count": newInstallationCount,
    "pending_installation_count": pendingInstallationCount,
    "completed_installation_count": completedInstallationCount,
    "all_service_tickets_counts": allServiceTicketsCounts,
    "new_order_count": newOrderCount,
    "pending_count": pendingCount,
    "completed_count": completedCount,
  };
}