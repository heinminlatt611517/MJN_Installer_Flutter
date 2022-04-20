import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:mjn_installer_app/controllers/page_argument_controller.dart';
import 'package:mjn_installer_app/network/RestApi.dart';
import 'package:mjn_installer_app/utils/app_constants.dart';
import 'package:mjn_installer_app/utils/app_utils.dart';
import 'package:mjn_installer_app/utils/eventbus_util.dart';

import 'home_controller.dart';

class NewOrderCustomerController extends GetxController {
  static NewOrderCustomerController get to => Get.find();
  DateTime? _chosenDateTime;
  final readData = GetStorage();
  var isLoading = false.obs;
  var dateController = TextEditingController();
  TimeOfDay? selectedTime = TimeOfDay.now();

  @override
  void onInit() {
    super.onInit();
  }

  void getDateTime() {
    debugPrint((DateFormat('yyyy-MM-dd – hh:mm a').format(_chosenDateTime!)));
  }

  void onTapAcceptNow(String ticketID, String profileID, String customerUID) {
    isLoading(true);
    PageArgumentController.to.getArgumentData() == INSTALLATION
        ? installationOrderAccept(profileID, customerUID)
        : serviceTicketOrderAccept(ticketID, profileID);
  }

  void selectDate(BuildContext context, String profileID, String ticketID,
      String customerUID) async {
    final DateTime? selected = await showDatePicker(
      initialDate: DateTime.now(),
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selected != null) {
      String dtFormat = DateFormat('dd/MM/yyyy').format(selected);
      debugPrint("DateTimeFormat${dtFormat}");
      dateController.text = dtFormat.toString();
      selectTimePicker(
          context, profileID, ticketID, customerUID, selected.toString());
    }
    else {

    }
  }

  void selectTimePicker(BuildContext context, String profileID, String ticketID,
      String customerUID, String date) async {
    final TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        initialEntryMode: TimePickerEntryMode.dial,
        confirmText: "CONFIRM",
        cancelText: "NOT NOW",
        helpText: "BOOKING TIME"
    );
    if (selectedTime != null) {
      var dateAndTime = dateController.text +
          ' ' + selectedTime.format(context);

      debugPrint("DateAndTimeValue::$dateAndTime");

      PageArgumentController.to.getArgumentData() ==
          INSTALLATION
          ? installationOrderLater(
          profileID, customerUID, date)
          : serviceTicketOrderLater(
          ticketID, profileID, date);
    }
  }

  void onTapLater(BuildContext context, String profileID, String ticketID,
      String customerUID) {
    selectDate(context, profileID, ticketID, customerUID);
  }

  void installationOrderLater(String profileID, String customerUID,
      String dateTime) {
    debugPrint('Installation later profileID${profileID}');
    Map<String, String> map = {
      'login_uid': readData.read(UID),
      'app_version': app_version,
      'profile_id': profileID,
      'customer_uid': customerUID,
      'status': 'later',
      'est_start_date': dateTime,
    };
    RestApi.installationOrderAcceptAndLater(map, readData.read(TOKEN))
        .then((value) =>
    {
      if (value.status == 'Success')
        {
          Future.delayed(Duration(seconds: 0), () {
            PageArgumentController.to.updateStatus(PENDING);
            EventBusUtils.getInstance().fire(PENDING);
            Get.back();
          })
        }
      else
        {AppUtils.showErrorSnackBar('Fail', 'Something wrong')}
    });
  }

  void installationOrderAccept(String profileID, String customerUID) {
    debugPrint('Installation accept profileID${profileID}');
    Map<String, String> map = {
      'login_uid': readData.read(UID),
      'app_version': app_version,
      'profile_id': profileID,
      'customer_uid': customerUID,
      'status': 'accept',
    };
    RestApi.installationOrderAcceptAndLater(map, readData.read(TOKEN))
        .then((value) =>
    {
      if (value.status == 'Success')
        {
          firstTimeSendSmSToServer(),
          isLoading(false),
          PageArgumentController.to.updateStatus(PENDING),
          EventBusUtils.getInstance().fire(PENDING),
          Get.offNamed(MY_LOCATION_PAGE)
        }
      else
        {
          isLoading(false),
          AppUtils.showErrorSnackBar('Fail', 'Something wrong')
        }
    });
  }

  void serviceTicketOrderLater(String ticketID, String profileID,
      String dateTime) {
    Map<String, String> map = {
      'uid': readData.read(UID),
      'ticket_id': ticketID,
      'status': 'later',
      'app_version': app_version,
      'profile_id': profileID,
      'est_start_date': dateTime,
    };

    RestApi.serviceTicketOrderAcceptAndLater(map, readData.read(TOKEN))
        .then((value) =>
    {
      if (value.status == 'Success')
        {
          Future.delayed(Duration(seconds: 0), () {
            PageArgumentController.to.updateStatus(PENDING);
            EventBusUtils.getInstance().fire(PENDING);
            Get.back();
          })
        }
      else
        {AppUtils.showErrorSnackBar('Fail', 'Something wrong')}
    });
  }

  void serviceTicketOrderAccept(String ticketID, String profileID) {
    Map<String, String> map = {
      'uid': readData.read(UID),
      'ticket_id': ticketID,
      'status': 'order_accept',
      'app_version': app_version,
      'profile_id': profileID,
    };

    RestApi.serviceTicketOrderAcceptAndLater(map, readData.read(TOKEN))
        .then((value) =>
    {
      if (value.status == 'Success')
        {
          firstTimeSendSmSToServer(),
          isLoading(false),
          PageArgumentController.to.updateStatus(PENDING),
          EventBusUtils.getInstance().fire(PENDING),
          Get.offNamed(MY_LOCATION_PAGE)
        }
      else
        {
          isLoading(false),
          AppUtils.showErrorSnackBar('Fail', 'Something Wrong')
        }
    });
  }


  void firstTimeSendSmSToServer() {
    Map<String, String> map = {
      'uid': readData.read(UID),
      'phone': HomeController.to.customerPhNo,
      'profile_id': HomeController.to.profileID,
      'app_version': app_version,
      'message_type' : PageArgumentController.to.getArgumentData() == INSTALLATION ? 'installation' : 'serviceTicket',
    };
    RestApi.firstTimeSendSMSToServer(map, readData.read(TOKEN)).then((value) =>
    {
      if(value.status == 'Success'){
        debugPrint('Success Send SMS')
      }
    });
  }

}
