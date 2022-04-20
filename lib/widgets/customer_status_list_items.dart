import 'package:flutter/material.dart';
import 'package:mjn_installer_app/controllers/home_controller.dart';
import 'package:mjn_installer_app/controllers/login_controller.dart';
import 'package:mjn_installer_app/controllers/page_argument_controller.dart';
import 'package:mjn_installer_app/models/allDropDownListVO.dart';
import 'package:mjn_installer_app/models/installationVO.dart';
import 'package:mjn_installer_app/models/serviceTicketVO.dart';
import 'package:mjn_installer_app/utils/app_constants.dart';
import 'package:get/get.dart';

class CustomerStatusListItems extends StatelessWidget {
  final String? customerName;
  final String? customerAddress;
  final String? customerPhNo;
  final String? profileId;
  final String? ticketId;
  final String? pageStatus;
  final String? township;
  final String? customerUID;
  final String? status;
  final String? status_txt;

  InstallationDetail? installationDetail;
  ServiceTicketDetail? serviceTicketDetail;
  List<TownshipDatum>? townshipLists;
  var townshipName = "".obs;

  CustomerStatusListItems(this.customerName, this.customerAddress,
      this.customerPhNo, this.profileId,
      {@required this.installationDetail,
      @required this.serviceTicketDetail,
      @required this.pageStatus,
      @required this.township,
      @required this.ticketId,
      @required this.customerUID,
        @required this.status_txt,
      @required this.status});

  @override
  Widget build(BuildContext context) {
    debugPrint(status);

    townshipLists =
        LoginController.to.maintenanceDropDownListsData.details!.townshipData;

    for (var i in townshipLists!) {
      debugPrint("${i.id} ${i.name}");
      if (i.id.toString() == customerAddress) {
        townshipName.value = i.name!;
      }
    }

    return Container(
        child: Container(
      margin: EdgeInsets.only(bottom: 10),

      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customerInfoLabel,
            middleLabel,
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    customerName!,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        color: Colors.black,
                        decoration: TextDecoration.none),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    customerPhNo!,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        color: Colors.black,
                        decoration: TextDecoration.none),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Obx(() {
                      return Text(
                        townshipName.value,
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                            color: Colors.black,
                            decoration: TextDecoration.none),
                      );
                    })),

                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    status_txt!,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        color: Colors.black,
                        decoration: TextDecoration.none),
                  ),
                ),
              ],
            ),
            verticalDivider,
            InkWell(
                onTap: () {

                  PageArgumentController.to.updateCustomerStatus(status_txt!);

                  if (pageStatus == NEW_ORDER) {
                    HomeController.to.updateNewOrderData(
                        customerName ?? '',
                        customerAddress ?? '',
                        customerPhNo ?? '',
                        township ?? '',
                        ticketId ?? '',
                        profileId ?? '',
                        customerUID ?? '');
                  } else if (pageStatus == PENDING) {
                    if (PageArgumentController.to.getArgumentData() ==
                        INSTALLATION) {
                      HomeController.to.updateInstallationData(
                          installationDetail!.profileId!,
                          installationDetail!.plan!,
                          installationDetail!.uid!,
                          installationDetail!.phone1!);
                    } else {
                      HomeController.to.updateServiceTicketData(
                          serviceTicketDetail!.ticketId!,
                          serviceTicketDetail!.profileId!,
                          serviceTicketDetail!.plan!,
                          serviceTicketDetail!.uid!,
                          serviceTicketDetail!.phone1!);
                    }
                  }

                  pageStatus == 'complete'
                      ? Get.toNamed(COMPLETE_CUSTOMER_DETAIL_PAGE,
                          arguments:
                              PageArgumentController.to.getArgumentData() ==
                                      INSTALLATION
                                  ? profileId
                                  : ticketId)
                      : pageStatus == NEW_ORDER
                          ? Get.toNamed(NEW_ORDER_CUSTOMER_PAGE)!.then(
                              (value) => Future.delayed(Duration.zero, () {
                                    if (PageArgumentController.to
                                            .getArgumentData() ==
                                        INSTALLATION) {
                                      if (PageArgumentController.to
                                              .getStatus() ==
                                          NEW_ORDER) {
                                        HomeController.to
                                            .fetchInstallationPendingCustomer(
                                                'newOrder', context);
                                      } else if (PageArgumentController.to
                                              .getStatus() ==
                                          PENDING) {
                                        HomeController.to
                                            .fetchInstallationPendingCustomer(
                                                'pending', context);
                                      }
                                    } else if (PageArgumentController.to
                                            .getArgumentData() ==
                                        SERVICE_TICKET) {
                                      if (PageArgumentController.to
                                              .getStatus() ==
                                          NEW_ORDER) {
                                        HomeController.to
                                            .fetchServiceTicketPendingCustomer(
                                                'newOrder', context);
                                      } else if (PageArgumentController.to
                                              .getStatus() ==
                                          PENDING) {
                                        HomeController.to
                                            .fetchServiceTicketPendingCustomer(
                                                'pending', context);
                                      }
                                    }
                                  }))
                          // pending ticket flow
                          //installation flow
                          : PageArgumentController.to.getArgumentData() ==
                                  INSTALLATION
                              ? status == '2'
                                  ? Get.toNamed(CUSTOMER_DETAIL_PAGE,
                                      arguments: profileId)
                                  : status == '8'
                                   ? Get.toNamed(CUSTOMER_DETAIL_PAGE,
                      arguments: profileId)
                                  : Get.offNamed(CUSTOMER_ISSUE_PAGE,
                                      arguments: profileId)

                              // service ticket flow
                              : status == '2'
                                  ? Get.toNamed(CUSTOMER_DETAIL_PAGE,
                                      arguments: ticketId)
                                  : status == '3'
                                  ? Get.toNamed(CUSTOMER_DETAIL_PAGE,
                      arguments: ticketId)
                                  : Get.offNamed(CUSTOMER_ISSUE_PAGE,
                                      arguments: ticketId);
                },
                child: labelView)
          ],
        ),
      ),
    ));
  }

  final customerInfoLabel = Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.all(2.0),
        child: Text(
          'Customer Name',
          style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 12,
              color: Colors.black,
              decoration: TextDecoration.none),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(2.0),
        child: Text(
          'Customer Ph No.',
          style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 12,
              color: Colors.black,
              decoration: TextDecoration.none),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(2.0),
        child: Text(
          'Township',
          style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 12,
              color: Colors.black,
              decoration: TextDecoration.none),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(2.0),
        child: Text(
          'Status',
          style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 12,
              color: Colors.black,
              decoration: TextDecoration.none),
        ),
      ),
    ],
  );

  final middleLabel = Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.all(2.0),
        child: Text(
          '-',
          style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 12,
              color: Colors.black,
              decoration: TextDecoration.none),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(2.0),
        child: Text(
          '-',
          style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 12,
              color: Colors.black,
              decoration: TextDecoration.none),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(2.0),
        child: Text(
          '-',
          style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 12,
              color: Colors.black,
              decoration: TextDecoration.none),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(2.0),
        child: Text(
          '-',
          style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 12,
              color: Colors.black,
              decoration: TextDecoration.none),
        ),
      ),
    ],
  );

  final verticalDivider = Container(
    height: 40,
    width: 1,
    color: Colors.grey,
  );

  final labelView = Text(
    'View',
    style: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 13,
        color: Colors.lightBlueAccent,
        decoration: TextDecoration.underline),
  );
}
