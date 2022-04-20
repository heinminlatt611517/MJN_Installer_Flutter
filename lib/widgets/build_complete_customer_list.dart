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

class BuildCompleteCustomerList extends StatefulWidget {
  @override
  State<BuildCompleteCustomerList> createState() =>
      _BuildCompleteCustomerListState();
}

class _BuildCompleteCustomerListState extends State<BuildCompleteCustomerList> {
  List<TownshipDatum>? townshipList;
  List<InstallationFilterStatus>? installationFilterStatusList;
  List<ServiceTicketFilterStatus>? serviceTicketFilterStatusList;

  @override
  void initState() {
    super.initState();
    firstTimeFetchDataFromNetwork();
    EventBusUtils.getInstance().fire(PENDING);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildWidget(context),
    );
  }

  Widget _buildWidget(BuildContext context) {
    townshipList =
        LoginController.to.maintenanceDropDownListsData.details!.townshipData;
    installationFilterStatusList = LoginController
        .to.maintenanceDropDownListsData.details!.installationFilterStatus;
    serviceTicketFilterStatusList = LoginController
        .to.maintenanceDropDownListsData.details!.serviceTicketFilterStatus;
    return Column(
      children: [
        SizedBox(
          height: 20.0,
        ),
        Text(
          'Complete Customer List',
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
            // Text(
            //   'Status',
            //   style: TextStyle(
            //       fontWeight: FontWeight.normal,
            //       fontSize: 12,
            //       color: Colors.black,
            //       decoration: TextDecoration.none),
            // ),
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
            Expanded(
              child: SearchTextFieldComponent(
                onTextDataChange: (String value) {
                  if (value == '') {
                    debugPrint('Empty text');
                    firstTimeFetchDataFromNetwork();
                  }
                },
                controller: HomeController.to.customerNameTextController,
                icon: Icons.search,
                onPressIcon: () {
                  PageArgumentController.to.getArgumentData() == SERVICE_TICKET
                      ? HomeController.to.fetchServiceTicketListsByStatus(
                          'completed',
                          context,
                          USERNAME_PARAM +
                              HomeController
                                  .to.customerNameTextController.value.text)
                      : HomeController.to.fetchInstallationListsByStatus(
                          'completed',
                          context,
                          USERNAME_PARAM +
                              HomeController
                                  .to.customerNameTextController.value.text);
                },
              ),
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
                    PageArgumentController.to.getArgumentData() ==
                            SERVICE_TICKET
                        ? HomeController.to.fetchServiceTicketListsByStatus(
                            'completed',
                            context,
                            TOWNSHIP_PARAM + value.id.toString())
                        : HomeController.to.fetchInstallationListsByStatus(
                            'completed',
                            context,
                            TOWNSHIP_PARAM + value.id.toString());
                  }
                },
                hintText: '--Select Township--',
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            // Obx(() {
            //   if (!PageArgumentController.to.isShowStatus.value) {
            //     return Container(
            //       height: 38,
            //       width: 90,
            //       decoration: BoxDecoration(
            //           color: Colors.white,
            //           borderRadius: BorderRadius.all(Radius.circular(4))),
            //       margin: EdgeInsets.only(bottom: 24),
            //       child: DropDownButtonComponent(
            //         itemsList: installationFilterStatusList,
            //         onChangedData: (InstallationFilterStatus value) {
            //           debugPrint('DropdownValue${value.key}');
            //
            //           if (value.name == "Select Status") {
            //             firstTimeFetchDataFromNetwork();
            //           } else {
            //             PageArgumentController.to.getArgumentData() ==
            //                     SERVICE_TICKET
            //                 ? HomeController.to.fetchServiceTicketListsByStatus(
            //                     'completed',
            //                     context,
            //                     FILTER_STATUS + value.id.toString())
            //                 : HomeController.to.fetchInstallationListsByStatus(
            //                     'completed',
            //                     context,
            //                     FILTER_STATUS + value.id.toString());
            //           }
            //         },
            //         hintText: '--Select Status--',
            //       ),
            //     );
            //   } else {
            //     return Container(
            //       height: 38,
            //       width: 90,
            //       decoration: BoxDecoration(
            //           color: Colors.white,
            //           borderRadius: BorderRadius.all(Radius.circular(4))),
            //       margin: EdgeInsets.only(bottom: 24),
            //       child: DropDownButtonComponent(
            //         itemsList: serviceTicketFilterStatusList,
            //         onChangedData: (ServiceTicketFilterStatus value) {
            //           debugPrint('DropdownValue${value.key}');
            //           if (value.name == "Select Status") {
            //             firstTimeFetchDataFromNetwork();
            //           } else {
            //             PageArgumentController.to.getArgumentData() ==
            //                 SERVICE_TICKET
            //                 ? HomeController.to.fetchServiceTicketListsByStatus(
            //                 'completed',
            //                 context,
            //                 FILTER_STATUS + value.id.toString())
            //                 : HomeController.to.fetchInstallationListsByStatus(
            //                 'completed',
            //                 context,
            //                 FILTER_STATUS + value.id.toString());
            //           }
            //         },
            //         hintText: '--Select Status--',
            //       ),
            //     );
            //   }
            // }),
            // SizedBox(
            //   width: 10.0,
            // ),
            Expanded(
                child: InkWell(
              onTap: () {
                HomeController.to.selectDate(context);
              },
              child: SearchTextFieldComponent(
                onTap: () {
                  //FocusScope.of(context).requestFocus(new FocusNode());
                  if (HomeController.to.customerDateController.text == "") {
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
                  PageArgumentController.to.getArgumentData() == SERVICE_TICKET
                      ? HomeController.to.fetchServiceTicketListsByStatus(
                          'completed',
                          context,
                          ASSIGNED_DATE_PARAM +
                              HomeController
                                  .to.customerDateController.value.text)
                      : HomeController.to.fetchInstallationListsByStatus(
                          'completed',
                          context,
                          ASSIGNED_DATE_PARAM +
                              HomeController
                                  .to.customerDateController.value.text);
                },
              ),
            )),
          ],
        ),
        Flexible(child: Obx(() {
          if (HomeController.to.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (PageArgumentController.to.getArgumentData() ==
              INSTALLATION) {
            if (HomeController.to.installationCompleteCustomerList.length ==
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
            if (HomeController.to.serviceTicketCompleteCustomerList.length ==
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
        }))
      ],
    );
  }

  void firstTimeFetchDataFromNetwork() {
    Future.delayed(Duration.zero, () {
      PageArgumentController.to.getArgumentData() == INSTALLATION
          ? HomeController.to
              .fetchInstallationCompleteCustomer('completed', context)
          : HomeController.to
              .fetchServiceTicketCompleteCustomer('completed', context);
    });
  }

  _buildListView() {
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemBuilder: (ctx, index) {
        return PageArgumentController.to.getArgumentData() == INSTALLATION
            ? CustomerStatusListItems(
                HomeController
                    .to.installationCompleteCustomerList[index].firstname,
                HomeController
                    .to.installationCompleteCustomerList[index].township,
                HomeController
                    .to.installationCompleteCustomerList[index].phone1,
                HomeController
                    .to.installationCompleteCustomerList[index].profileId,
                pageStatus: 'complete',
                status_txt: HomeController
                    .to.installationCompleteCustomerList[index].status_txt,
              )
            : CustomerStatusListItems(
                HomeController
                    .to.serviceTicketCompleteCustomerList[index].firstname,
                HomeController
                    .to.serviceTicketCompleteCustomerList[index].township,
                HomeController
                    .to.serviceTicketCompleteCustomerList[index].phone1,
                HomeController
                    .to.serviceTicketCompleteCustomerList[index].profileId,
                ticketId: HomeController
                    .to.serviceTicketCompleteCustomerList[index].ticketId,
                status_txt: HomeController
                    .to.serviceTicketCompleteCustomerList[index].status_txt,
                pageStatus: 'complete',
              );
      },
      itemCount: PageArgumentController.to.getArgumentData() == INSTALLATION
          ? HomeController.to.installationCompleteCustomerList.length
          : HomeController.to.serviceTicketCompleteCustomerList.length,
    );
  }
}
