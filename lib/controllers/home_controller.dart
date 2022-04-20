import 'package:flutter/material.dart';
import 'package:mjn_installer_app/controllers/login_controller.dart';
import 'package:mjn_installer_app/controllers/page_argument_controller.dart';
import 'package:mjn_installer_app/models/installationVO.dart';
import 'package:mjn_installer_app/models/serviceTicketVO.dart';
import 'package:mjn_installer_app/models/serviceTicket_and_installation_countsVO.dart';
import 'package:mjn_installer_app/network/RestApi.dart';
import 'package:mjn_installer_app/utils/app_constants.dart';
import 'package:mjn_installer_app/utils/app_utils.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  var customerNameTextController = TextEditingController();

  var customerDateController = TextEditingController();
  final installationPendingCustomerList = <InstallationDetail>[].obs;
  final serviceTicketPendingCustomerList = <ServiceTicketDetail>[].obs;

  final installationCompleteCustomerList = <InstallationDetail>[].obs;
  final serviceTicketCompleteCustomerList = <ServiceTicketDetail>[].obs;

  final serviceTicketAndInstallationCounts =
      ServiceTicketAdnInstallationCountsVO().obs;

  var isEmptyData = '';

  var installationPendingCount = 0.obs;
  var installationCompleteCount = 0.obs;

  var serviceTicketPendingCount = 0.obs;
  var serviceTicketCompleteCount = 0.obs;

  final readData = GetStorage();
  var isLoading = false.obs;
  var homeLoading = false.obs;


  String argumentData = '';

  //user data for location page
  var customerProfileID;
  var customerPhoneNo;

  //for new order page
  var customerName;
  var customerAddress;
  var customerPhNo;
  var customerTownship;
  var ticketID;
  var profileID;
  var customerUID;

  //service ticket
  var serviceTicketID;
  var serviceProfileID;
  var serviceCustomerType;
  var serviceCustomerUid;


  //installation
  var installationProfileID;
  var installationCustomerType;
  var installationCustomerUid;

  static HomeController get to => Get.find();

  @override
  void onInit() {
    Get.put(LoginController());
    super.onInit();
  }

  void onUIReady(BuildContext context) {
    fetchAllCountsForServiceTicketAndInstallation(context);
  }

  void updateProfileID (String cProfileID){
    profileID = cProfileID;
    update();
  }

  void clearTextFieldData() {
    customerNameTextController.text = '';

    customerDateController.text = '';
    update();
  }

  void updateServiceTicketData(String ticketId, String profileId,
      String customerType, String customerUid,String customerPhone) {
    serviceTicketID = ticketId;
    serviceProfileID = profileId;
    serviceCustomerType = customerType;
    serviceCustomerUid = customerUid;
    customerPhoneNo = customerPhone;
    customerProfileID = profileId;
    update();
  }

  void updateInstallationData(String profileId,
      String customerType, String customerUid,String customerPhone) {
    installationProfileID = profileId;
    installationCustomerType = customerType;
    installationCustomerUid = customerUid;
    customerPhoneNo = customerPhone;
    customerProfileID = profileId;

    update();
  }

  void updateNewOrderData(String cName, String cAddress, String cPhNo,
      String cTownship, String cTicketID, String cProfileID, String cUID) {
    customerName = cName;
    customerAddress = cAddress;
    customerPhNo = cPhNo;
    customerTownship = cTownship;
    ticketID = cTicketID;
    profileID = cProfileID;
    customerUID = cUID;
    update();
  }

  @override
  void onClose() {
    installationPendingCustomerList.clear();
    serviceTicketPendingCustomerList.clear();
    super.onClose();
  }

  @override
  void dispose() {
    installationPendingCustomerList.clear();
    serviceTicketPendingCustomerList.clear();
    super.dispose();
  }

  void updateArgumentData(String argument) {
    argumentData = argument;
    update();
  }

  String getArgumentData() {
    return argumentData;
  }

  void selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      initialDate: DateTime.now(),
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selected != null) {
      String dtFormat = DateFormat('dd/MM/yyyy').format(selected);
      debugPrint("DateTimeFormat${dtFormat}");
      customerDateController.text = dtFormat.toString();
    }
  }

  void fetchServiceTicketPendingCustomer(String status, BuildContext context) {
    clearTextFieldData();
    Future.delayed(Duration.zero, () {
      isLoading(true);
      RestApi.fetchServiceTicketPendingLists(
              readData.read(TOKEN), readData.read(UID), status)
          .then((value) => {
                if (value.status == 'Success')
                  {
                    debugPrint("ServiceTicketLists ${value.details}"),
                    serviceTicketPendingCustomerList.value = value.details!,
                    isLoading(false)
                  }
                else if (value.responseCode == '005')
                  {
                    isLoading(false),
                    AppUtils.showSessionExpireDialog(
                        'Fail', 'Session Expired', context)
                  }
                else
                  {isLoading(false)}
              });
    });
  }

  void fetchInstallationPendingCustomer(String status, BuildContext context) {
    clearTextFieldData();
    Future.delayed(Duration.zero, () {
      isLoading(true);
      RestApi.fetchInstallationPendingLists(
              readData.read(TOKEN), readData.read(UID), status)
          .then((value) => {
                if (value.status == 'Success')
                  {
                    debugPrint("InstallationLists ${value.details}"),
                    installationPendingCustomerList.value = value.details!,
                    isLoading(false)
                  }
                else if (value.responseCode == '005')
                  {
                    isLoading(false),
                    AppUtils.showSessionExpireDialog(
                        'Fail', 'Session Expired', context)
                  }
                else
                  {isLoading(false)}
              });
    });
  }

  void fetchServiceTicketCompleteCustomer(String status, BuildContext context) {
    clearTextFieldData();
    Future.delayed(Duration.zero, () {
      isLoading(true);
      RestApi.fetchServiceTicketPendingLists(
              readData.read(TOKEN), readData.read(UID), status)
          .then((value) => {
                if (value.status == 'Success')
                  {
                    debugPrint("ServiceTicketLists ${value.details}"),
                    serviceTicketCompleteCustomerList.value = value.details!,
                    isLoading(false)
                  }
                else if (value.responseCode == '005')
                  {
                    isLoading(false),
                    AppUtils.showSessionExpireDialog(
                        'Fail', 'Session Expired', context)
                  }
                else
                  {isLoading(false)}
              });
    });
  }

  void fetchInstallationCompleteCustomer(String status, BuildContext context) {
    clearTextFieldData();
    Future.delayed(Duration.zero, () {
      isLoading(true);
      RestApi.fetchInstallationPendingLists(
              readData.read(TOKEN), readData.read(UID), status)
          .then((value) => {
                if (value.status == 'Success')
                  {
                    debugPrint("InstallationLists ${value.details}"),
                    installationCompleteCustomerList.value = value.details!,
                    isLoading(false)
                  }
                else if (value.responseCode == '005')
                  {
                    isLoading(false),
                    AppUtils.showSessionExpireDialog(
                        'Fail', 'Session Expired', context)
                  }
                else
                  {isLoading(false)}
              });
    });
  }

  void fetchAllCountsForServiceTicketAndInstallation(BuildContext context) {
    Future.delayed(Duration.zero, () {
      homeLoading(true);
      RestApi.fetchAllCountsForInstallationAndService(
              readData.read(UID), readData.read(TOKEN))
          .then((value) => {
                if (value.status == 'Success')
                  {
                    homeLoading(false),
                    serviceTicketAndInstallationCounts.value = value
                  }
                else if (value.responseCode == '005')
                  {
                    homeLoading(false),
                    AppUtils.showSessionExpireDialog(
                        'Fail', 'Session Expired', context)
                  }
                else if (value.isRequieredUpdate!)
                  {
                    AppUtils.showRequireUpdateDialog(
                        'Update Require', 'A new update is available', context)
                  }
                else
                  {homeLoading(false)}
              });
    });
  }

  void fetchServiceTicketListsByStatus(
      String status, BuildContext context, String paramAndStatus) {
    debugPrint('ParamStatusServiceTicket ::$paramAndStatus');
    Future.delayed(Duration.zero, () {
      isLoading(true);
      RestApi.fetchServiceTicketListsByStatus(
              readData.read(TOKEN), readData.read(UID), status, paramAndStatus)
          .then((value) => {
                if (value.status == 'Success')
                  {
                    debugPrint("Service Ticket ${value.details}"),
                    if (status == 'completed')
                      {
                        serviceTicketCompleteCustomerList.value =
                            value.details!,
                        debugPrint(
                            "Service Ticket length ${serviceTicketCompleteCustomerList.length}"),
                        if (serviceTicketCompleteCustomerList.length == 0)
                          {
                            //firstTimeFetchDataFromNetwork(context)
                          },
                        isLoading(false)
                      }
                    else
                      {
                        serviceTicketPendingCustomerList.value = value.details!,
                        isLoading(false)
                      }
                  }
                else if (value.responseCode == '005')
                  {
                    isLoading(false),
                    AppUtils.showSessionExpireDialog(
                        'Fail', 'Session Expired', context)
                  }
                else
                  {isLoading(false)}
              });
    });
  }

  void fetchInstallationListsByStatus(
      String status, BuildContext context, String paramAndStatus) {
    debugPrint('ParamStatus ::$paramAndStatus');
    Future.delayed(Duration.zero, () {
      isLoading(true);
      RestApi.fetchInstallationListsByStatus(
              readData.read(TOKEN), readData.read(UID), status, paramAndStatus)
          .then((value) => {
                if (value.status == 'Success')
                  {
                    debugPrint("InstallationLists ${value.details}"),
                    if (status == 'completed')
                      {
                        installationCompleteCustomerList.value = value.details!,
                        if (installationCompleteCustomerList.length == 0)
                          {
                            //firstTimeFetchDataFromNetwork(context)
                          },
                        isLoading(false)
                      }
                    else
                      {
                        installationPendingCustomerList.value = value.details!,
                        isLoading(false)
                      }
                  }
                else if (value.responseCode == '005')
                  {
                    isLoading(false),
                    AppUtils.showSessionExpireDialog(
                        'Fail', 'Session Expired', context)
                  }
                else
                  {isLoading(false)}
              });
    });
  }

  void firstTimeFetchDataFromNetwork(BuildContext context) {
    Future.delayed(Duration.zero, () {
      PageArgumentController.to.getArgumentData() == INSTALLATION
          ? fetchInstallationCompleteCustomer('completed', context)
          : fetchServiceTicketCompleteCustomer('completed', context);
    });
  }

  void firstTimeFetchDataFromNetworkForPending(BuildContext context) {
    Future.delayed(Duration.zero, () {
      if (PageArgumentController.to.getArgumentData() == INSTALLATION) {
        if (PageArgumentController.to.getStatus() == NEW_ORDER) {
          HomeController.to
              .fetchInstallationPendingCustomer('newOrder', context);
        } else if (PageArgumentController.to.getStatus() == PENDING) {
          HomeController.to
              .fetchInstallationPendingCustomer('pending', context);
        }
      } else if (PageArgumentController.to.getArgumentData() ==
          SERVICE_TICKET) {
        if (PageArgumentController.to.getStatus() == NEW_ORDER) {
          HomeController.to
              .fetchServiceTicketPendingCustomer('newOrder', context);
        } else if (PageArgumentController.to.getStatus() == PENDING) {
          HomeController.to
              .fetchServiceTicketPendingCustomer('pending', context);
        }
      }
    });
  }
}
