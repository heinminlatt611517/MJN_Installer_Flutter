import 'package:flutter/cupertino.dart';
import 'package:mjn_installer_app/models/installationDetailVO.dart';
import 'package:mjn_installer_app/models/serviceTicketDetailVO.dart';
import 'package:mjn_installer_app/network/RestApi.dart';
import 'package:mjn_installer_app/utils/app_constants.dart';
import 'package:mjn_installer_app/utils/app_utils.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CustomerDetailController extends GetxController{
  final readData = GetStorage();
  var installationDetail = InstallationDetails().obs;
  var serviceTicketDetail = ServiceTicketDetails().obs;
  var isLoading = false.obs;

  static CustomerDetailController get to => Get.find();

  void fetchInstallationDetail(String profileID,BuildContext context){
    isLoading(true);
    RestApi.getInstallationDetail(readData.read(TOKEN),
        readData.read(UID),profileID).then((value) => {
          if(value.status == 'Success'){
            installationDetail.value = value.details!,
            isLoading(false)
          }
          else if(value.responseCode == '005'){
            isLoading(false),
            AppUtils.showSessionExpireDialog('Fail', 'Session Expired', context)
          }
          else {
            isLoading(false)
          }

    });
  }

  void fetchServiceTicketDetail(String ticketID,BuildContext context){
    isLoading(true);
    RestApi.getServiceTicketDetail(readData.read(TOKEN),
        readData.read(UID),ticketID).then((value) => {
      if(value.status == 'Success'){
        serviceTicketDetail.value = value.details!,
        isLoading(false)
      }
      else if(value.responseCode == '005'){
        isLoading(false),
        AppUtils.showSessionExpireDialog('Fail', 'Session Expired', context)
      }
      else {
        isLoading(false)
      }

    });
  }

}