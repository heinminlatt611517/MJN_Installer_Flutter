import 'package:flutter/material.dart';
import 'package:mjn_installer_app/components/button_component.dart';
import 'package:mjn_installer_app/components/label_text_component.dart';
import 'package:mjn_installer_app/controllers/customer_detail_controller.dart';
import 'package:mjn_installer_app/utils/app_constants.dart';
import 'package:get/get.dart';

class BuildPendingCustomerCompleteInfo extends StatefulWidget {
  final String ticketID;

  BuildPendingCustomerCompleteInfo(this.ticketID);

  @override
  State<BuildPendingCustomerCompleteInfo> createState() =>
      _BuildPendingCustomerCompleteInfoState();
}

class _BuildPendingCustomerCompleteInfoState
    extends State<BuildPendingCustomerCompleteInfo> {
  CustomerDetailController customerDetailController =
      Get.put(CustomerDetailController());

  @override
  void initState() {
    Future.delayed(Duration.zero,(){
      customerDetailController.fetchServiceTicketDetail(widget.ticketID,context);
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
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(child: customerLabel),
                Flexible(child: middleLabel),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      LabelTextComponent(
                          text:  (customerDetailController
                              .serviceTicketDetail.value.userName == null || customerDetailController
                              .serviceTicketDetail.value.userName == "") ?
                          "xx xxx xxx xxx xxx" : customerDetailController
                              .serviceTicketDetail.value.userName!,
                          color: Colors.black,
                          padding: 8.0),

                      LabelTextComponent(
                          text: customerDetailController
                                  .serviceTicketDetail.value.firstname ??
                              "xx xxx xxx xxx xxx",
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
                                  .serviceTicketDetail.value.longitude ??
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
                                  .serviceTicketDetail.value.subconAssignedDate ??
                              "xx xxx xxx xxx xxx",
                          color: Colors.black,
                          padding: 8.0),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 40,
            ),
            ButtonComponent(
              text: 'Customer Complete',
              padding: 10,
              containerWidth: 150,
              color: Colors.grey,
              onPress: () => onPressCustomerComplete(),
            ),
          ],
        );
    });
  }

  void onPressCustomerComplete() {
    Get.offNamed(COMPLETE_CUSTOMER_PAGE);
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
    ],
  );
}
