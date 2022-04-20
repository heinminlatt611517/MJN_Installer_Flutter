import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mjn_installer_app/components/button_component.dart';
import 'package:mjn_installer_app/components/label_text_component.dart';
import 'package:mjn_installer_app/controllers/customer_detail_controller.dart';
import 'package:mjn_installer_app/controllers/home_controller.dart';
import 'package:mjn_installer_app/controllers/page_argument_controller.dart';
import 'package:mjn_installer_app/network/RestApi.dart';
import 'package:mjn_installer_app/res/colors.dart';
import 'package:mjn_installer_app/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:mjn_installer_app/utils/app_utils.dart';
import 'package:mjn_installer_app/utils/eventbus_util.dart';

class BuildCustomerDetailInfo extends StatefulWidget {
  final String profileIdOrTicketID;
  String? status;

  BuildCustomerDetailInfo(this.profileIdOrTicketID, {this.status});

  @override
  State<BuildCustomerDetailInfo> createState() =>
      _BuildCustomerDetailInfoState();
}

class _BuildCustomerDetailInfoState extends State<BuildCustomerDetailInfo> {
  CustomerDetailController customerDetailController =
  Get.put(CustomerDetailController());

  final writeData = GetStorage();
  final readData = GetStorage();

  @override
  void initState() {
    debugPrint("Customer Phone Number${HomeController.to.customerPhoneNo}");
    Future.delayed(Duration.zero, () {
      if (PageArgumentController.to.getArgumentData() == INSTALLATION) {
        customerDetailController.fetchInstallationDetail(
            widget.profileIdOrTicketID, context);
      } else {
        customerDetailController.fetchServiceTicketDetail(
            widget.profileIdOrTicketID, context);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (customerDetailController.isLoading.value) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else
        return PageArgumentController.to.getArgumentData() == INSTALLATION
            ? Flexible(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  customerLabel,
                  middleLabel,
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LabelTextComponent(
                            text: customerDetailController
                                .installationDetail
                                .value
                                .user_name ==
                                null
                                ? "xx xxx xxx xxx xxx"
                                : customerDetailController
                                .installationDetail.value.user_name!,
                            color: Colors.black,
                            padding: 8.0),
                        LabelTextComponent(
                            text: customerDetailController
                                .installationDetail
                                .value
                                .firstname ==
                                null
                                ? "xx xxx xxx xxx xxx"
                                : customerDetailController
                                .installationDetail.value.firstname!,
                            color: Colors.black,
                            padding: 8.0),
                        LabelTextComponent(
                            text: customerDetailController
                                .installationDetail.value.phone1 ??
                                "xx xxx xxx xxx xxx",
                            color: Colors.black,
                            padding: 8.0),
                        LabelTextComponent(
                            text: customerDetailController
                                .installationDetail.value.address ??
                                "xx xxx xxx xxx xxx",
                            color: Colors.black,
                            padding: 8.0),
                        LabelTextComponent(
                            text: customerDetailController
                                .installationDetail.value.latitude ??
                                "xx xxx xxx xxx xxx",
                            color: Colors.black,
                            padding: 8.0),
                        LabelTextComponent(
                            text: customerDetailController
                                .installationDetail.value.longitude ??
                                "xx xxx xxx xxx xxx",
                            color: Colors.black,
                            padding: 8.0),
                        LabelTextComponent(
                            text: customerDetailController
                                .installationDetail.value.type ??
                                "xx xxx xxx xxx xxx",
                            color: Colors.black,
                            padding: 8.0),
                        LabelTextComponent(
                            text: 'xx xxx xxx xxx xxx',
                            color: Colors.black,
                            padding: 8.0),
                        LabelTextComponent(
                            text: customerDetailController
                                .installationDetail
                                .value
                                .subconAssignedDate ??
                                "xx xxx xxx xxx xxx",
                            color: Colors.black,
                            padding: 8.0),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 60,
              ),
              widget.status == 'complete'
                  ? Container()
                  : ButtonComponent(
                text: PageArgumentController.to.getCustomerStatus() ==
                  ORDER_ACCEPTED ? 'Dispatch Now'
                  :'Installation Started',
                padding: 10,
                containerWidth
                    : 140.0,
                color: Color(int.parse(MJNColors.buttonColor)),
                onPress: () => onPressInstallationStart(),
              ),
            ],
          ),
        )
            : Flexible(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  customerLabel,
                  middleLabel,
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LabelTextComponent(
                            text: (customerDetailController
                                .serviceTicketDetail
                                .value
                                .userName ==
                                null ||
                                customerDetailController
                                    .serviceTicketDetail
                                    .value
                                    .userName ==
                                    "")
                                ? "xx xxx xxx xxx xxx"
                                : customerDetailController
                                .serviceTicketDetail.value.userName!,
                            color: Colors.black,
                            padding: 8.0),
                        LabelTextComponent(
                            text: customerDetailController
                                .serviceTicketDetail
                                .value
                                .firstname ==
                                null
                                ? "xx xxx xxx xxx xxx"
                                : customerDetailController
                                .serviceTicketDetail.value.firstname!,
                            color: Colors.black,
                            padding: 8.0),
                        LabelTextComponent(
                            text: customerDetailController
                                .serviceTicketDetail.value.phone1 ??
                                "xx xxx xxx xxx xxx",
                            color: Colors.black,
                            padding: 8.0),
                        LabelTextComponent(
                            text: customerDetailController
                                .serviceTicketDetail.value.address ??
                                "xx xxx xxx xxx xxx",
                            color: Colors.black,
                            padding: 8.0),
                        LabelTextComponent(
                            text: customerDetailController
                                .serviceTicketDetail.value.latitude ??
                                "xx xxx xxx xxx xxx",
                            color: Colors.black,
                            padding: 8.0),
                        LabelTextComponent(
                            text: customerDetailController
                                .serviceTicketDetail
                                .value
                                .longitude ??
                                "xx xxx xxx xxx xxx",
                            color: Colors.black,
                            padding: 8.0),
                        LabelTextComponent(
                            text: customerDetailController
                                .serviceTicketDetail.value.type ??
                                "xx xxx xxx xxx xxx",
                            color: Colors.black,
                            padding: 8.0),
                        LabelTextComponent(
                            text: 'xx xxx xxx xxx xxx',
                            color: Colors.black,
                            padding: 8.0),
                        LabelTextComponent(
                            text: customerDetailController
                                .serviceTicketDetail
                                .value
                                .subconAssignedDate ??
                                "xx xxx xxx xxx xxx",
                            color: Colors.black,
                            padding: 8.0),
                        LabelTextComponent(
                            text: customerDetailController
                                .serviceTicketDetail
                                .value
                                .message ??
                                "xx xxx xxx xxx xxx",
                            color: Colors.black,
                            padding: 8.0),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 60,
              ),
              widget.status == 'complete'
                  ? Container()
                  : ButtonComponent(
                text: PageArgumentController.to.getCustomerStatus() ==
                    ORDER_ACCEPTED ? 'Dispatch Now'
                    : 'Action Started',
                padding: 10,
                containerWidth: 120.0,
                color: Color(int.parse(MJNColors.buttonColor)),
                onPress: () => onPressActionStart(),
              ),
            ],
          ),
        );
    });
  }


  void onPressInstallationStart(){
    PageArgumentController.to.getCustomerStatus() == ORDER_ACCEPTED ? installationOrderAccept()
        : installationStart();
  }



  void onPressActionStart() {

    PageArgumentController.to.getCustomerStatus() == ORDER_ACCEPTED ? serviceTicketOrderAccept()
        : serviceTicketActionStart();
  }

  final customerLabel = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      LabelTextComponent(text: 'User ID', color: Colors.black, padding: 8.0),
      LabelTextComponent(
          text: 'Customer Name', color: Colors.black, padding: 8.0),
      LabelTextComponent(
          text: 'Customer Phone', color: Colors.black, padding: 8.0),
      LabelTextComponent(text: 'Address', color: Colors.black, padding: 8.0),
      LabelTextComponent(text: 'Lat', color: Colors.black, padding: 8.0),
      LabelTextComponent(text: 'Long', color: Colors.black, padding: 8.0),
      LabelTextComponent(text: 'Type', color: Colors.black, padding: 8.0),
      LabelTextComponent(text: 'Topic', color: Colors.black, padding: 8.0),
      LabelTextComponent(
          text: 'Assigned Date', color: Colors.black, padding: 8.0),
      PageArgumentController.to.getArgumentData() == SERVICE_TICKET
          ? LabelTextComponent(text: 'Note', color: Colors.black, padding: 8.0)
          : SizedBox(),
    ],
  );

  final middleLabel = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      LabelTextComponent(text: '- - -', color: Colors.black, padding: 8.0),
      LabelTextComponent(text: '- - -', color: Colors.black, padding: 8.0),
      LabelTextComponent(text: '- - -', color: Colors.black, padding: 8.0),
      LabelTextComponent(text: '- - -', color: Colors.black, padding: 8.0),
      LabelTextComponent(text: '- - -', color: Colors.black, padding: 8.0),
      LabelTextComponent(text: '- - -', color: Colors.black, padding: 8.0),
      LabelTextComponent(text: '- - -', color: Colors.black, padding: 8.0),
      LabelTextComponent(text: '- - -', color: Colors.black, padding: 8.0),
      LabelTextComponent(text: '- - -', color: Colors.black, padding: 8.0),
      PageArgumentController.to.getArgumentData() == SERVICE_TICKET
          ? LabelTextComponent(text: '- - -', color: Colors.black, padding: 8.0)
          : SizedBox(),
    ],
  );

  void installationOrderAccept() {
    writeData.write(SAVE_TIME, DateTime.now().minute);
    HomeController.to.updateProfileID(HomeController.to.installationProfileID);
    debugPrint('Installation accept profileID${HomeController.to.installationProfileID}');
    Map<String, String> map = {
      'login_uid': readData.read(UID),
      'app_version': app_version,
      'profile_id': HomeController.to.installationProfileID,
      'customer_uid': HomeController.to.installationCustomerUid,
      'status': 'accept',
    };
    RestApi.installationOrderAcceptAndLater(map, readData.read(TOKEN))
        .then((value) =>
    {
      if (value.status == 'Success')
        {
          firstTimeSendInstallationSmSToServer(),
          PageArgumentController.to.updateStatus(PENDING),
          EventBusUtils.getInstance().fire(PENDING),
          Get.offNamed(MY_LOCATION_PAGE)
        }
      else
        {
          AppUtils.showErrorSnackBar('Fail', 'Something wrong')
        }
    });
  }


  void firstTimeSendInstallationSmSToServer() {
    debugPrint("Customer Phone Number${HomeController.to.customerPhoneNo}");
    Map<String, String> map = {
      'uid': readData.read(UID),
      'phone': HomeController.to.customerPhoneNo,
      'profile_id': HomeController.to.installationProfileID,
      'app_version': app_version,
      'message_type' : 'installation',
    };
    RestApi.firstTimeSendSMSToServer(map, readData.read(TOKEN)).then((value) =>
    {
      if(value.status == 'Success'){
        debugPrint('Success Send SMS')
      }
    });
  }


  void installationStart() {
    debugPrint('Installation accept profileID${HomeController.to.installationProfileID}');
    Map<String, String> map = {
      'login_uid': readData.read(UID),
      'app_version': app_version,
      'profile_id': HomeController.to.installationProfileID,
      'customer_uid': HomeController.to.installationCustomerUid,
      'status': 'action_start',
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
        {
          AppUtils.showErrorSnackBar('Fail', 'Something wrong')
        }
    });
  }





  void serviceTicketOrderAccept() {
    writeData.write(SAVE_TIME, DateTime.now().minute);
    HomeController.to.updateProfileID(HomeController.to.serviceProfileID);
    Map<String, String> map = {
      'uid': readData.read(UID),
      'ticket_id': HomeController.to.serviceTicketID,
      'status': 'order_accept',
      'app_version': app_version,
      'profile_id': HomeController.to.serviceProfileID,
    };

    RestApi.serviceTicketOrderAcceptAndLater(map, readData.read(TOKEN))
        .then((value) =>
    {
      if (value.status == 'Success')
        {
          firstTimeSendServiceSmSToServer(),

          PageArgumentController.to.updateStatus(PENDING),
          EventBusUtils.getInstance().fire(PENDING),
          Get.offNamed(MY_LOCATION_PAGE)
        }
      else
        {
          AppUtils.showErrorSnackBar('Fail', 'Something Wrong')
        }
    });
  }

  void serviceTicketActionStart() {
    Map<String, String> map = {
      'uid': readData.read(UID),
      'ticket_id': HomeController.to.serviceTicketID,
      'status': 'action_start',
      'app_version': app_version,
      'profile_id': HomeController.to.serviceProfileID,
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
        {
          AppUtils.showErrorSnackBar('Fail', 'Something Wrong')
        }
    });
  }


  void firstTimeSendServiceSmSToServer() {
    debugPrint("Customer Phone Number${HomeController.to.customerPhoneNo}");
    Map<String, String> map = {
      'uid': readData.read(UID),
      'phone': HomeController.to.customerPhoneNo,
      'profile_id': HomeController.to.serviceProfileID,
      'app_version': app_version,
      'message_type' : 'serviceTicket',
    };
    RestApi.firstTimeSendSMSToServer(map, readData.read(TOKEN)).then((value) =>
    {
      if(value.status == 'Success'){
        debugPrint('Success Send SMS')
      }
    });
  }

}
