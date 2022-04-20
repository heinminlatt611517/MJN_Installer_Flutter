import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mjn_installer_app/components/drop_down_button_component.dart';
import 'package:mjn_installer_app/components/search_text_field_component.dart';
import 'package:mjn_installer_app/controllers/home_controller.dart';
import 'package:mjn_installer_app/controllers/login_controller.dart';
import 'package:mjn_installer_app/controllers/page_argument_controller.dart';
import 'package:mjn_installer_app/models/allDropDownListVO.dart';
import 'package:mjn_installer_app/utils/app_constants.dart';
import 'package:mjn_installer_app/utils/eventbus_util.dart';
import 'customer_status_list_items.dart';
import 'package:get/get.dart';

class BuildPendingAndNewOrderCustomerList extends StatefulWidget {
  @override
  State<BuildPendingAndNewOrderCustomerList> createState() =>
      _BuildPendingAndNewOrderCustomerListState();
}

class _BuildPendingAndNewOrderCustomerListState
    extends State<BuildPendingAndNewOrderCustomerList>
    with WidgetsBindingObserver {
  List<TownshipDatum>? townshipList;
  List<InstallationFilterStatus>? installationFilterStatusList;
  List<ServiceTicketFilterStatus>? serviceTicketFilterStatusList;
  var customerStatusTitle = ''.obs;
  late StreamSubscription titleSub;

  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    firstTimeFetchDataFromNetwork();
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint(state.toString());
    if (state == AppLifecycleState.resumed) {
      print('onResume');
    }
  }

  @override
  void didChangeDependencies() {
    print('onResumeDependencies');
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    titleSub = EventBusUtils.getInstance().on().listen((event) {
      if (event.toString() == PENDING) {
        firstTimeFetchDataFromNetwork();
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          if (this.mounted) {
            setState(() {
              PageArgumentController.to.updateStatusTitle(PENDING);
            });
          }
        });
      } else {
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          if (this.mounted) {
            setState(() {
              PageArgumentController.to.updateStatusTitle(NEW_ORDER);
            });
          }
        });
      }
    });

    debugPrint('Status Title ${PageArgumentController.to.getStatusTitle()}');
    townshipList =
        LoginController.to.maintenanceDropDownListsData.details!.townshipData;
    installationFilterStatusList =
        LoginController.to.maintenanceDropDownListsData.details!.installationFilterStatus;
    serviceTicketFilterStatusList =
        LoginController.to.maintenanceDropDownListsData.details!.serviceTicketFilterStatus;
    return Container(
      child: _buildWidget(context),
    );
  }

  Widget _buildWidget(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20.0,
        ),
        Text(
          PageArgumentController.to.getStatusTitle() == NEW_ORDER
              ? 'New Order Customer List'
              : 'Pending Customer List',
          style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 20,
              color: Colors.black,
              decoration: TextDecoration.none),
        ),
        SizedBox(
          height: 20.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Customer Name',
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                  color: Colors.black,
                  decoration: TextDecoration.none),
            ),
            Text(
              'Township',
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                  color: Colors.black,
                  decoration: TextDecoration.none),
            ),
            Text(
              'Status',
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                  color: Colors.black,
                  decoration: TextDecoration.none),
            ),
            Text(
              'Assigned Date',
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                  color: Colors.black,
                  decoration: TextDecoration.none),
            ),
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GetBuilder<HomeController>(
              builder: (controller) => Expanded(
                  child: SearchTextFieldComponent(
                onTextDataChange: (String value) {
                  if (value == '') {
                    debugPrint('Empty text');
                    firstTimeFetchDataFromNetwork();
                  }
                },
                controller: controller.customerNameTextController,
                icon: Icons.search,
                onPressIcon: () {
                  if (PageArgumentController.to.getArgumentData() ==
                      SERVICE_TICKET) {
                    if (PageArgumentController.to.getStatus() == NEW_ORDER) {
                      HomeController.to.fetchServiceTicketListsByStatus(
                          'newOrder',
                          context,
                          USERNAME_PARAM +
                              HomeController
                                  .to.customerNameTextController.value.text);
                    } else if (PageArgumentController.to.getStatus() ==
                        PENDING) {
                      HomeController.to.fetchServiceTicketListsByStatus(
                          'pending',
                          context,
                          USERNAME_PARAM +
                              HomeController
                                  .to.customerNameTextController.value.text);
                    }
                  } else if (PageArgumentController.to.getArgumentData() ==
                      INSTALLATION) {
                    if (PageArgumentController.to.getStatus() == NEW_ORDER) {
                      HomeController.to.fetchInstallationListsByStatus(
                          'newOrder',
                          context,
                          USERNAME_PARAM +
                              HomeController
                                  .to.customerNameTextController.value.text);
                    } else if (PageArgumentController.to.getStatus() ==
                        PENDING) {
                      HomeController.to.fetchInstallationListsByStatus(
                          'pending',
                          context,
                          USERNAME_PARAM +
                              HomeController
                                  .to.customerNameTextController.value.text);
                    }
                  }
                },
              )),
            ),
            SizedBox(
              width: 10.0,
            ),
            Container(
              height: 38,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              margin: EdgeInsets.only(bottom: 24),
              child: DropDownButtonComponent(
                itemsList: townshipList,
                onChangedData: (TownshipDatum value) {
                  debugPrint('DropdownValue${value.key}');

                  if (value.name == "Select Township") {
                    firstTimeFetchDataFromNetwork();
                  } else {
                    if (PageArgumentController.to.getArgumentData() ==
                        SERVICE_TICKET) {
                      if (PageArgumentController.to.getStatus() == NEW_ORDER) {
                        HomeController.to.fetchServiceTicketListsByStatus(
                            'newOrder',
                            context,
                            TOWNSHIP_PARAM + value.id.toString());
                      } else if (PageArgumentController.to.getStatus() ==
                          PENDING) {
                        HomeController.to.fetchServiceTicketListsByStatus(
                            'pending',
                            context,
                            TOWNSHIP_PARAM + value.id.toString());
                      }
                    } else if (PageArgumentController.to.getArgumentData() ==
                        INSTALLATION) {
                      if (PageArgumentController.to.getStatus() == NEW_ORDER) {
                        HomeController.to.fetchInstallationListsByStatus(
                            'newOrder',
                            context,
                            TOWNSHIP_PARAM + value.id.toString());
                      } else if (PageArgumentController.to.getStatus() ==
                          PENDING) {
                        HomeController.to.fetchInstallationListsByStatus(
                            'pending',
                            context,
                            TOWNSHIP_PARAM + value.id.toString());
                      }
                    }
                  }
                },
                hintText: '--Select Township--',
              ),
            ),
            SizedBox(
              width: 10.0,
            ),


          Obx((){
            if(!PageArgumentController.to.isShowStatus.value)
              {
                return
                  Container(
                    height: 38,
                    width: 90,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    margin: EdgeInsets.only(bottom: 24),
                    child: DropDownButtonComponent(
                      itemsList: installationFilterStatusList,
                      onChangedData: (InstallationFilterStatus value) {
                        debugPrint('DropdownValue${value.key}');

                        if (value.name == "Select Status") {
                          firstTimeFetchDataFromNetwork();
                        } else {
                          if (PageArgumentController.to.getArgumentData() ==
                              SERVICE_TICKET) {
                            if (PageArgumentController.to.getStatus() == NEW_ORDER) {
                              HomeController.to.fetchServiceTicketListsByStatus(
                                  'newOrder',
                                  context,
                                  FILTER_STATUS + value.id.toString());
                            } else if (PageArgumentController.to.getStatus() ==
                                PENDING) {
                              HomeController.to.fetchServiceTicketListsByStatus(
                                  'pending',
                                  context,
                                  FILTER_STATUS + value.id.toString());
                            }
                          } else if (PageArgumentController.to.getArgumentData() ==
                              INSTALLATION) {
                            if (PageArgumentController.to.getStatus() == NEW_ORDER) {
                              HomeController.to.fetchInstallationListsByStatus(
                                  'newOrder',
                                  context,
                                  FILTER_STATUS + value.id.toString());
                            } else if (PageArgumentController.to.getStatus() ==
                                PENDING) {
                              HomeController.to.fetchInstallationListsByStatus(
                                  'pending',
                                  context,
                                  FILTER_STATUS + value.id.toString());
                            }
                          }
                        }
                      },
                      hintText: '--Select Status--',
                    ),
                  );
              }
            else {
              return
                Container(
                  height: 38,
                  width: 90,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  margin: EdgeInsets.only(bottom: 24),
                  child: DropDownButtonComponent(
                    itemsList: serviceTicketFilterStatusList,
                    onChangedData: (ServiceTicketFilterStatus value) {
                      debugPrint('DropdownValue${value.key}');

                      if (value.name == "Select Status") {
                        firstTimeFetchDataFromNetwork();
                      } else {
                        if (PageArgumentController.to.getArgumentData() ==
                            SERVICE_TICKET) {
                          if (PageArgumentController.to.getStatus() == NEW_ORDER) {
                            HomeController.to.fetchServiceTicketListsByStatus(
                                'newOrder',
                                context,
                                FILTER_STATUS + value.id.toString());
                          } else if (PageArgumentController.to.getStatus() ==
                              PENDING) {
                            HomeController.to.fetchServiceTicketListsByStatus(
                                'pending',
                                context,
                                FILTER_STATUS + value.id.toString());
                          }
                        } else if (PageArgumentController.to.getArgumentData() ==
                            INSTALLATION) {
                          if (PageArgumentController.to.getStatus() == NEW_ORDER) {
                            HomeController.to.fetchInstallationListsByStatus(
                                'newOrder',
                                context,
                                FILTER_STATUS + value.id.toString());
                          } else if (PageArgumentController.to.getStatus() ==
                              PENDING) {
                            HomeController.to.fetchInstallationListsByStatus(
                                'pending',
                                context,
                                FILTER_STATUS + value.id.toString());
                          }
                        }
                      }
                    },
                    hintText: '--Select Status--',
                  ),
                );
            }
          })  ,


            SizedBox(
              width: 10.0,
            ),
            GetBuilder<HomeController>(
                builder: (controller) => Expanded(
                        child: SearchTextFieldComponent(
                      onTap: () {
                        //FocusScope.of(context).requestFocus(new FocusNode());
                        if (HomeController.to.customerDateController.text ==
                            "") {
                          HomeController.to..selectDate(context);
                        }
                      },
                      onTextDataChange: (String value) {
                        if (value == '') {
                          debugPrint('Empty text');
                          firstTimeFetchDataFromNetwork();
                        }
                      },
                      controller: HomeController.to.customerDateController,
                      icon: Icons.search,
                      onPressIcon: () {
                        if (PageArgumentController.to.getArgumentData() ==
                            SERVICE_TICKET) {
                          if (PageArgumentController.to.getStatus() ==
                              NEW_ORDER) {
                            HomeController.to.fetchServiceTicketListsByStatus(
                                'newOrder',
                                context,
                                ASSIGNED_DATE_PARAM +
                                    HomeController
                                        .to.customerDateController.value.text);
                          } else if (PageArgumentController.to.getStatus() ==
                              PENDING) {
                            HomeController.to.fetchServiceTicketListsByStatus(
                                'pending',
                                context,
                                ASSIGNED_DATE_PARAM +
                                    HomeController
                                        .to.customerDateController.value.text);
                          }
                        } else if (PageArgumentController.to
                                .getArgumentData() ==
                            INSTALLATION) {
                          if (PageArgumentController.to.getStatus() ==
                              NEW_ORDER) {
                            HomeController.to.fetchInstallationListsByStatus(
                                'newOrder',
                                context,
                                ASSIGNED_DATE_PARAM +
                                    HomeController
                                        .to.customerDateController.value.text);
                          } else if (PageArgumentController.to.getStatus() ==
                              PENDING) {
                            HomeController.to.fetchInstallationListsByStatus(
                                'pending',
                                context,
                                ASSIGNED_DATE_PARAM +
                                    HomeController
                                        .to.customerDateController.value.text);
                          }
                        }
                      },
                    )))
          ],
        ),
        Flexible(
          child: Obx(() {
            if (HomeController.to.isLoading.value) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (PageArgumentController.to.getArgumentData() ==
                INSTALLATION) {
              if (HomeController.to.installationPendingCustomerList.length ==
                  0) {
                return Center(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 50.0),
                        color: Colors.transparent,
                        child: Image(
                          image: AssetImage('assets/no_result_found.png'),
                          height: 200,
                          width: 200,
                        ),
                      ),
                    ),
                    Expanded(
                        child: Text(
                      'Sorry! No data found :(',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black45),
                    ))
                  ],
                ));
              } else
                return _buildListView();
            } else if (PageArgumentController.to.getArgumentData() ==
                SERVICE_TICKET) {
              if (HomeController.to.serviceTicketPendingCustomerList.length ==
                  0) {
                return Center(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 50.0),
                        color: Colors.transparent,
                        child: Image(
                          image: AssetImage('assets/no_result_found.png'),
                          height: 200,
                          width: 200,
                        ),
                      ),
                    ),
                    Expanded(
                        child: Text(
                      'Sorry! No data found :(',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black45),
                    ))
                  ],
                ));
              } else
                return _buildListView();
            } else
              return _buildListView();
          }),
        )
      ],
    );
  }

  _buildListView() {
    return GetBuilder<HomeController>(
        builder: (controller) => ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (ctx, index) {
                return controller.getArgumentData() == INSTALLATION
                    ? CustomerStatusListItems(
                        controller
                            .installationPendingCustomerList[index].firstname,
                        controller
                            .installationPendingCustomerList[index].township,
                        controller
                            .installationPendingCustomerList[index].phone1,
                        controller
                            .installationPendingCustomerList[index].profileId,
                        pageStatus:
                            PageArgumentController.to.getStatus() == NEW_ORDER
                                ? NEW_ORDER
                                : PENDING,
                        township: controller
                            .installationPendingCustomerList[index].township,
                        customerUID: controller
                            .installationPendingCustomerList[index].uid,
                        status: controller
                            .installationPendingCustomerList[index].status,
                        installationDetail:
                            controller.installationPendingCustomerList[index],
                        status_txt: controller
                            .installationPendingCustomerList[index].status_txt,
                      )
                    : CustomerStatusListItems(
                        controller
                            .serviceTicketPendingCustomerList[index].firstname,
                        controller
                            .serviceTicketPendingCustomerList[index].township,
                        controller
                            .serviceTicketPendingCustomerList[index].phone1,
                        controller
                            .serviceTicketPendingCustomerList[index].profileId,
                        ticketId: controller
                            .serviceTicketPendingCustomerList[index].ticketId,
                        pageStatus:
                            PageArgumentController.to.getStatus() == NEW_ORDER
                                ? NEW_ORDER
                                : PENDING,
                        township: controller
                            .serviceTicketPendingCustomerList[index].township,
                        status: controller
                            .serviceTicketPendingCustomerList[index].status,
                        status_txt: controller
                            .serviceTicketPendingCustomerList[index].status_txt,
                        serviceTicketDetail:
                            controller.serviceTicketPendingCustomerList[index],
                      );
              },
              itemCount: controller.getArgumentData() == INSTALLATION
                  ? controller.installationPendingCustomerList.length
                  : controller.serviceTicketPendingCustomerList.length,
            ));
  }

  void firstTimeFetchDataFromNetwork() {
    Future.delayed(Duration.zero, () {
      if (this.mounted) {
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
      }
    });
  }
}
