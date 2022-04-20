import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mjn_installer_app/components/button_component.dart';
import 'package:mjn_installer_app/components/label_text_component.dart';
import 'package:mjn_installer_app/controllers/home_controller.dart';
import 'package:mjn_installer_app/controllers/login_controller.dart';
import 'package:mjn_installer_app/controllers/new_order_customer_controller.dart';
import 'package:mjn_installer_app/models/allDropDownListVO.dart';
import 'package:mjn_installer_app/res/colors.dart';
import 'package:mjn_installer_app/utils/app_constants.dart';
import 'package:mjn_installer_app/utils/app_utils.dart';
import 'package:get/get.dart';

class NewOrderCustomerPage extends StatefulWidget {
  @override
  State<NewOrderCustomerPage> createState() => _NewOrderCustomerPageState();
}

class _NewOrderCustomerPageState extends State<NewOrderCustomerPage> {
  final NewOrderCustomerController controller =
      Get.put(NewOrderCustomerController());

  List<TownshipDatum>? townshipLists;

  var isShowView = true.obs;
  static var township = "".obs;
  final writeData = GetStorage();

  @override
  void initState() {
    super.initState();
    isShowView(true);
  }

  @override
  Widget build(BuildContext context) {
    townshipLists =
        LoginController.to.maintenanceDropDownListsData.details!.townshipData;

    for (var i in townshipLists!) {
      debugPrint("${i.id} ${i.name}");
      if (i.id.toString() == HomeController.to.customerTownship.toString()) {
        setState(() {
          township.value = i.name!;
        });
      }
    }

    debugPrint("TownshipName::${township}");
    return Scaffold(
        appBar: AppUtils.customAppBar(),
        backgroundColor: Color(int.parse(MJNColors.bgColor)),
        body: _buildWidget(context));
  }

  _buildWidget(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Container(
            child: Center(
          child: CircularProgressIndicator(),
        ));
      } else
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                height: 20.0,
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                child: Column(
                  children: [
                    Text(
                      'New Order',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 20,
                          color: Colors.black,
                          decoration: TextDecoration.none),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [customerLabel, middleLabel, Flexible(child: customerData)],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Obx(() {
                      return Visibility(
                        visible: isShowView.value ? true : false,
                        child: ButtonComponent(
                          text: 'Accept Now',
                          containerWidth: 120,
                          padding: 10,
                          color: Color(int.parse(MJNColors.buttonColor)),
                          onPress: () => {isShowView(false)},
                        ),
                      );
                    }),
                    Obx(() {
                      return Visibility(
                        visible: !isShowView.value ? true : false,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ButtonComponent(
                              text: 'Dispatch Now',
                              containerWidth: 120,
                              padding: 10,
                              color: Color(int.parse(MJNColors.buttonColor)),
                              onPress: () => {
                              writeData.write(SAVE_TIME, DateTime.now().minute),
                                controller.onTapAcceptNow(
                                    HomeController.to.ticketID,
                                    HomeController.to.profileID,
                                    HomeController.to.customerUID)
                              },
                            ),
                            ButtonComponent(
                              text: 'Later',
                              containerWidth: 120,
                              padding: 10,
                              color: Color(int.parse(MJNColors.buttonColor)),
                              onPress: () => {
                                controller.onTapLater(
                                    context,
                                    HomeController.to.profileID,
                                    HomeController.to.ticketID,
                                    HomeController.to.customerUID)
                              },
                            )
                          ],
                        ),
                      );
                    }),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
    });
  }

  final customerData = Obx(() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelTextComponent(
            text: HomeController.to.customerName == null
                ? "xx xxx xxx xxx"
                : HomeController.to.customerName,
            color: Colors.black,
            padding: 8.0),
        LabelTextComponent(
            text: township.value, color: Colors.black, padding: 8.0),
        LabelTextComponent(
            text: HomeController.to.customerPhNo == null
                ? "xx xxx xxx xxx"
                : HomeController.to.customerPhNo,
            color: Colors.black,
            padding: 8.0),
        LabelTextComponent(
            text: township.value, color: Colors.black, padding: 8.0),
      ],
    );
  });
  final customerLabel = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      LabelTextComponent(
          text: 'Customer Name', color: Colors.black, padding: 8.0),
      LabelTextComponent(text: 'Address', color: Colors.black, padding: 8.0),
      LabelTextComponent(text: 'Phone No', color: Colors.black, padding: 8.0),
      LabelTextComponent(text: 'Township', color: Colors.black, padding: 8.0),
    ],
  );

  final middleLabel = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      LabelTextComponent(text: '-', color: Colors.black, padding: 8.0),
      LabelTextComponent(text: '-', color: Colors.black, padding: 8.0),
      LabelTextComponent(text: '-', color: Colors.black, padding: 8.0),
      LabelTextComponent(text: '-', color: Colors.black, padding: 8.0),
    ],
  );
}
