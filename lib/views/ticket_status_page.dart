import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mjn_installer_app/components/ticket_status_component.dart';
import 'package:mjn_installer_app/controllers/home_controller.dart';
import 'package:mjn_installer_app/controllers/page_argument_controller.dart';
import 'package:mjn_installer_app/controllers/ticket_status_controller.dart';
import 'package:mjn_installer_app/res/colors.dart';
import 'package:mjn_installer_app/utils/app_constants.dart';
import 'package:mjn_installer_app/utils/app_utils.dart';
import 'package:mjn_installer_app/components/bottom_nav_bar_component.dart';
import 'package:get/get.dart';
import 'package:mjn_installer_app/utils/eventbus_util.dart';

class TicketStatusPage extends StatefulWidget {
  @override
  State<TicketStatusPage> createState() => _TicketStatusPageState();
}

class _TicketStatusPageState extends State<TicketStatusPage>  with WidgetsBindingObserver{
  final TicketStatusController ticketStatusController =
      Get.put(TicketStatusController());

  late StreamSubscription resumeSub;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    debugPrint(state.toString());
    if(state == AppLifecycleState.resumed){
      debugPrint('onResumeState');
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    HomeController.to.onUIReady(context);
    resumeSub = EventBusUtils.getInstance().on().listen((event) {
      if (event.toString() == 'resume') {
        HomeController.to.onUIReady(context);
      }

    });

    return WillPopScope(
      onWillPop: (){
        Get.offAllNamed(HOME);
        return Future.value(true);
      },
      child: Scaffold(
          appBar: AppUtils.customAppBar(),
          backgroundColor: Color(int.parse(MJNColors.bgColor)),
          body: Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(left: 30, right: 30, bottom: 30),
            child: _buildWidget(),
          ),
          bottomNavigationBar: GetBuilder<TicketStatusController>(
              init: TicketStatusController(),
              initState: (_) {
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  ticketStatusController.updateArgumentData(
                      PageArgumentController.to.getArgumentData());
                });
              },
              builder: (controller) => BottomNavigationBarComponent(
                    argumentData: controller.argumentData,
                    onChangedData: (val) {
                      controller.updateArgumentData(val);
                      PageArgumentController.to.updateArgumentData(val);
                      if (val == INSTALLATION) {
                        controller.fetchInstallationData();
                      } else {
                        controller.fetchServiceTicketData();
                      }
                    },
                  ))),
    );
  }

  _buildWidget() {
    return Obx(() {
      if (HomeController.to.homeLoading.value) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else
        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 60.0,
              ),
              GetBuilder<TicketStatusController>(
                builder: (controller) => Text(
                  ticketStatusController.getArgumentData() == INSTALLATION
                      ? "Total - ${HomeController.to.serviceTicketAndInstallationCounts.value.allInstallationCounts.toString()}"
                      : "Total - ${HomeController.to.serviceTicketAndInstallationCounts.value.allServiceTicketsCounts.toString()}",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                      color: Colors.black,
                      decoration: TextDecoration.underline),
                ),
              ),
              SizedBox(
                height: 60.0,
              ),

              GetBuilder<TicketStatusController>(
                  builder: (controller) => TicketStatusComponent(
                      argumentData: controller.getArgumentData(),
                      status: NEW_ORDER,
                      routeName: CUSTOMER_STATUS_PAGE,
                      count: ticketStatusController.getArgumentData() ==
                          INSTALLATION
                          ? HomeController
                          .to
                          .serviceTicketAndInstallationCounts
                          .value
                          .newInstallationCount
                          .toString()
                          : HomeController
                          .to
                          .serviceTicketAndInstallationCounts
                          .value
                          .newOrderCount
                          .toString(),
                      assertImage: 'assets/installation_img.png')),
              SizedBox(
                height: 20,
              ),

              GetBuilder<TicketStatusController>(
                  builder: (controller) => TicketStatusComponent(
                      argumentData:
                          ticketStatusController.getArgumentData(),
                      status: PENDING,
                      routeName: CUSTOMER_STATUS_PAGE,
                      count: ticketStatusController.getArgumentData() ==
                              INSTALLATION
                          ? HomeController
                              .to
                              .serviceTicketAndInstallationCounts
                              .value
                              .pendingInstallationCount
                              .toString()
                          : HomeController
                              .to
                              .serviceTicketAndInstallationCounts
                              .value
                              .pendingCount
                              .toString(),
                      assertImage: 'assets/pending_img.png')),

              SizedBox(
                height: 20.0,
              ),

              GetBuilder<TicketStatusController>(
                builder: (controller) => TicketStatusComponent(
                    argumentData: controller.getArgumentData(),
                    status: COMPLETE,
                    routeName: COMPLETE_CUSTOMER_PAGE,
                    count:
                        ticketStatusController.getArgumentData() == INSTALLATION
                            ? HomeController
                                .to
                                .serviceTicketAndInstallationCounts
                                .value
                                .completedInstallationCount
                                .toString()
                            : HomeController
                                .to
                                .serviceTicketAndInstallationCounts
                                .value
                                .completedCount
                                .toString(),
                    assertImage: 'assets/complete_img.png'),
              )
            ],
          ),
        );
    });
  }
}
