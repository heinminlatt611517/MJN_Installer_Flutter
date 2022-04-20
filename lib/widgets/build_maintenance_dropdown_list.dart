import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mjn_installer_app/components/button_component.dart';
import 'package:mjn_installer_app/components/drop_down_button_component.dart';
import 'package:mjn_installer_app/components/label_text_component.dart';
import 'package:mjn_installer_app/components/photo_picker_component.dart';
import 'package:mjn_installer_app/components/text_field_box_decoration_component.dart';
import 'package:mjn_installer_app/components/text_field_with_label_box_decoration_component.dart';
import 'package:mjn_installer_app/controllers/home_controller.dart';
import 'package:mjn_installer_app/controllers/login_controller.dart';
import 'package:mjn_installer_app/controllers/service_ticket_controller.dart';
import 'package:mjn_installer_app/models/allDropDownListVO.dart';
import 'package:mjn_installer_app/res/colors.dart';
import 'package:get/get.dart';

class BuildMaintenanceDropdownList extends StatefulWidget {
  @override
  State<BuildMaintenanceDropdownList> createState() =>
      _BuildMaintenanceDropdownListState();
}

class _BuildMaintenanceDropdownListState
    extends State<BuildMaintenanceDropdownList> {
  ServiceTicketController serviceTicketController =
      Get.put(ServiceTicketController());

  List<IssueDatum>? issueLists;
  List<IssueDatum>? resolutionLists;
  List<IssueDatum>? statusLists;

  @override
  void initState() {
    serviceTicketController.onUIReady(HomeController.to.serviceTicketID);
    super.initState();
    debugPrint('CustomerType::${HomeController.to.serviceCustomerType}');
  }

  @override
  Widget build(BuildContext context) {
    issueLists =
        LoginController.to.maintenanceDropDownListsData.details!.issueData!;
    resolutionLists = LoginController
        .to.maintenanceDropDownListsData.details!.technicalResolution!;
    statusLists = LoginController
        .to.maintenanceDropDownListsData.details!.serviceTicketData!;

    debugPrint("IssueListSize ${issueLists!.length}");
    return Obx(() {
      if (serviceTicketController.isLoading.value) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else
        return Column(
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
                          text: (serviceTicketController
                                      .serviceTicketDetail.value.userName ==
                                  null || serviceTicketController
                              .serviceTicketDetail.value.userName == "")
                              ? "xx xxx xxx xxx xxx"
                              : serviceTicketController
                                  .serviceTicketDetail.value.userName!,
                          color: Colors.black,
                          padding: 8.0),
                      LabelTextComponent(
                          text: serviceTicketController
                                  .serviceTicketDetail.value.phone1 ??
                              "xx xxx xxx xxx xxx",
                          color: Colors.black,
                          padding: 8.0),
                      LabelTextComponent(
                          text: serviceTicketController
                                  .serviceTicketDetail.value.address ??
                              "xx xxx xxx xxx xxx",
                          color: Colors.black,
                          padding: 8.0),
                      LabelTextComponent(
                          text: serviceTicketController
                                  .serviceTicketDetail.value.latitude ??
                              "xx xxx xxx xxx xxx",
                          color: Colors.black,
                          padding: 8.0),
                      LabelTextComponent(
                          text: serviceTicketController
                                  .serviceTicketDetail.value.longitude ??
                              "xx xxx xxx xxx xxx",
                          color: Colors.black,
                          padding: 8.0),
                      LabelTextComponent(
                          text: serviceTicketController
                                  .serviceTicketDetail.value.type ??
                              "xx xxx xxx xxx xxx",
                          color: Colors.black,
                          padding: 8.0),
                      LabelTextComponent(
                          text: serviceTicketController
                              .serviceTicketDetail.value.topic ??
                              "xx xxx xxx xxx xxx",
                          color: Colors.black,
                          padding: 8.0),
                      LabelTextComponent(
                          text: serviceTicketController
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
              height: 10.0,
            ),
            Container(
                width: Get.width,
                margin: EdgeInsets.only(left: 15.0, right: 24.0),
                child: HomeController.to.serviceCustomerType == 'b2b'
                    ? _buildB2BUsage()
                    : _buildB2CUsage()),

            FittedBox(
              child: Container(
                margin: EdgeInsets.only(left: 24.0, right: 24.0, top: 24.0),
                child: Row(
                  children: [
                    choosePhotoListsWidget(context),
                  ],
                ),
              ),
            ),

            SizedBox(
              height: 40.0,
            ),
            Obx(() {
              if (serviceTicketController.loadingForButton.value) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else
                return ButtonComponent(
                  text: 'Complete',
                  containerWidth: 120,
                  padding: 10,
                  color: Color(int.parse(MJNColors.buttonColor)),
                  onPress: () => onPressComplete(),
                );
            })
          ],
        );
    });
  }

  final issueDropDownLabel = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      LabelTextComponent(
          text: 'Technical Issue', color: Colors.black, padding: 8.0),
      LabelTextComponent(
          text: 'Technical Resolution', color: Colors.black, padding: 8.0),
      // LabelTextComponent(
      //     text: 'Usage', color: Colors.black, padding: 8.0),
      LabelTextComponent(text: 'Status', color: Colors.black, padding: 8.0),

      LabelTextComponent(text: 'MAC ID', color: Colors.black, padding: 8.0),
      LabelTextComponent(text: 'Device ID', color: Colors.black, padding: 8.0),
    ],
  );

  final customerLabel = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
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
    ],
  );

  Widget choosePhotoListsWidget(BuildContext context) {
   return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('ONU Image'),
        SizedBox(
          height: 10,
        ),
        FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GetBuilder<ServiceTicketController>(
                builder: (controller) =>
                    PhotoPickerComponent(
                      imagePath: controller.image_onu_front_side,
                      text: 'Front Side',
                      onPress: () => {controller.onTapONUFrontSide(context)},
                    ),
              ),
              SizedBox(
                width: 20,
              ),
              GetBuilder<ServiceTicketController>(
                builder: (controller) =>
                    PhotoPickerComponent(
                      imagePath: controller.image_onu_back_side,
                      text: 'Back Side',
                      onPress: () => {controller.onTapONUBackSide(context)},
                    ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text('ODB Image'),
        SizedBox(
          height: 10,
        ),
        FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GetBuilder<ServiceTicketController>(
                builder: (controller) =>
                    PhotoPickerComponent(
                      imagePath: controller.image_odb_before,
                      text: 'Before ODB Photo',
                      onPress: () => {controller.onTapODBBefore(context)},
                    ),
              ),
              SizedBox(
                width: 20,
              ),
              GetBuilder<ServiceTicketController>(
                builder: (controller) =>
                    PhotoPickerComponent(
                      imagePath: controller.image_odb_after,
                      text: 'After ODB Photo',
                      onPress: () => {controller.onTapODBAfter(context)},
                    ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text('Spliter Image'),
        SizedBox(
          height: 10,
        ),
        FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GetBuilder<ServiceTicketController>(
                builder: (controller) =>
                    PhotoPickerComponent(
                      imagePath: controller.image_spliter_before,
                      text: 'Before Spliter Photo',
                      onPress: () => {controller.onTapSpliterBefore(context)},
                    ),
              ),
              SizedBox(
                width: 20,
              ),
              GetBuilder<ServiceTicketController>(
                builder: (controller) =>
                    PhotoPickerComponent(
                      imagePath: controller.image_spliter_after,
                      text: 'After Spliter Photo',
                      onPress: () => {controller.onTapSpliterAfter(context)},
                    ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text('Service Acceptance Form'),
        GetBuilder<ServiceTicketController>(
          builder: (controller) =>
              PhotoPickerComponent(
                imagePath: controller.imageAcceptForm,
                text: '',
                onPress: () => {controller.onTapAcceptForm(context)},
              ),
        ),
      ],
    );
  }

  _buildB2BUsage() {
    return Row(
      children: [
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: LabelTextComponent(
                        text: 'Sr No.', color: Colors.black, padding: 8.0)),
                Flexible(
                  flex: 2,
                  child: GetBuilder<ServiceTicketController>(
                    init: ServiceTicketController(),
                    builder: (controller) => TextFieldBoxDecorationComponent(
                      controller: controller.macIdController,
                      errorText: '',
                      hintText: '',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: LabelTextComponent(
                        text: 'Spliter No.',
                        color: Colors.black,
                        padding: 8.0)),
                Flexible(
                  flex: 2,
                  child: GetBuilder<ServiceTicketController>(
                    init: ServiceTicketController(),
                    builder: (controller) => TextFieldBoxDecorationComponent(
                      controller: controller.deviceIdController,
                      errorText: '',
                      hintText: '',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: LabelTextComponent(
                        text: 'Port No.', color: Colors.black, padding: 8.0)),
                Flexible(
                  flex: 2,
                  child: GetBuilder<ServiceTicketController>(
                    init: ServiceTicketController(),
                    builder: (controller) => TextFieldBoxDecorationComponent(
                      controller: controller.portNoController,
                      errorText: '',
                      hintText: '',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: LabelTextComponent(
                        text: 'Technical Issue',
                        color: Colors.black,
                        padding: 8.0)),
                Flexible(
                  flex: 2,
                  child: DropDownButtonComponent(
                    itemsList: issueLists,
                    onChangedData: (IssueDatum value) {
                      debugPrint('DropdownValue${value.id}');
                      serviceTicketController
                          .updateTechnicalIssueValueID(value.id!);
                      if(value.name == 'Other'){
                        serviceTicketController.isShowTechnicalIssueNote(true);
                      }
                      else{
                        serviceTicketController.isShowTechnicalIssueNote(false);
                      }
                    },
                    hintText: '--Select Issue--',
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),


            Obx((){
              if(serviceTicketController.isShowTechnicalIssueNote.value){
                return
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        Expanded(
                            child: LabelTextComponent(
                                text: 'Note', color: Colors.black, padding: 8.0)),
                        Flexible(
                          flex: 2,
                          child: GetBuilder<ServiceTicketController>(
                            init: ServiceTicketController(),
                            builder: (controller) => TextFieldBoxDecorationComponent(
                              controller: controller.technicalIssueNoteController,
                              errorText: '',
                              hintText: '',
                            ),
                          ),
                        ),
                      ],),

                      SizedBox(
                        height: 10,
                      ),

                    ],
                  );
              }
              else{
                return Container();
              }
            }),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: LabelTextComponent(
                        text: 'Technical Resolution',
                        color: Colors.black,
                        padding: 8.0)),
                Flexible(
                  flex: 2,
                  child: DropDownButtonComponent(
                    itemsList: resolutionLists,
                    onChangedData: (IssueDatum value) {
                      debugPrint('DropdownValue${value.id}');
                      serviceTicketController
                          .updateTechnicalResolutionValueID(value.id!);

                      if(value.name == "Other"){
                        serviceTicketController.isShowTechnicalResolutionNote(true);
                      }
                      else{
                        serviceTicketController.isShowTechnicalResolutionNote(false);
                      }

                    },
                    hintText: '--Select Resolution--',
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),

            Obx((){
              if(serviceTicketController.isShowTechnicalResolutionNote.value){
                return
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        Expanded(
                            child: LabelTextComponent(
                                text: 'Note', color: Colors.black, padding: 8.0)),
                        Flexible(
                          flex: 2,
                          child: GetBuilder<ServiceTicketController>(
                            init: ServiceTicketController(),
                            builder: (controller) => TextFieldBoxDecorationComponent(
                              controller: controller.technicalResolutionNoteController,
                              errorText: '',
                              hintText: '',
                            ),
                          ),
                        ),
                      ],),

                      SizedBox(
                        height: 10,
                      ),

                    ],
                  );
              }
              else{
                return Container();
              }
            }),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: LabelTextComponent(
                        text: 'Status', color: Colors.black, padding: 8.0)),
                Flexible(
                  flex: 2,
                  child: DropDownButtonComponent(
                    itemsList: statusLists,
                    onChangedData: (IssueDatum value) {
                      debugPrint('DropdownValue${value.id}');
                      serviceTicketController.updateStatusValueID(value.id!);
                    },
                    hintText: '--Select Status--',
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: LabelTextComponent(
                        text: 'Cable Type', color: Colors.black, padding: 8.0)),
                Flexible(
                  flex: 2,
                  child: Container(
                    width: Get.width,
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Colors.black38),
                        borderRadius: BorderRadius.all(Radius.circular(2.0))),
                    child: ExpandableNotifier(
                        // <-- Provides ExpandableController to its children
                        child: _buildInstallationUsages(
                            '--Select Cable Type--',
                            serviceTicketController.b2bInstallationUsages.value
                                .details!.cableType)),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: LabelTextComponent(
                        text: 'Joint Closure',
                        color: Colors.black,
                        padding: 8.0)),
                Flexible(
                  flex: 2,
                  child: Container(
                    width: Get.width,
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Colors.black38),
                        borderRadius: BorderRadius.all(Radius.circular(2.0))),
                    child: ExpandableNotifier(
                      // <-- Provides ExpandableController to its children
                      child: _buildInstallationUsages(
                          '--Select Joint Closure--',
                          serviceTicketController.b2bInstallationUsages.value
                              .details!.jointClosure),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: LabelTextComponent(
                        text: 'ODB', color: Colors.black, padding: 8.0)),
                Flexible(
                  flex: 2,
                  child: Container(
                    width: Get.width,
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Colors.black38),
                        borderRadius: BorderRadius.all(Radius.circular(2.0))),
                    child: ExpandableNotifier(
                      // <-- Provides ExpandableController to its children
                      child: _buildInstallationUsages(
                          '--Select ODB--',
                          serviceTicketController
                              .b2bInstallationUsages.value.details!.oDB),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: LabelTextComponent(
                        text: 'ONU', color: Colors.black, padding: 8.0)),
                Flexible(
                  flex: 2,
                  child: Container(
                    width: Get.width,
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Colors.black38),
                        borderRadius: BorderRadius.all(Radius.circular(2.0))),
                    child: ExpandableNotifier(
                      // <-- Provides ExpandableController to its children
                      child: _buildInstallationUsages(
                          '--Select ONU--',
                          serviceTicketController
                              .b2bInstallationUsages.value.details!.oNU),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: LabelTextComponent(
                        text: 'Cat6 Cable', color: Colors.black, padding: 8.0)),
                Flexible(
                  flex: 2,
                  child: Container(
                    width: Get.width,
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Colors.black38),
                        borderRadius: BorderRadius.all(Radius.circular(2.0))),
                    child: ExpandableNotifier(
                      // <-- Provides ExpandableController to its children
                      child: _buildInstallationUsages(
                          '--Select Cat6 Cable--',
                          serviceTicketController
                              .b2bInstallationUsages.value.details!.cat6Cable),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: LabelTextComponent(
                        text: 'RJ-45 Connector',
                        color: Colors.black,
                        padding: 8.0)),
                Flexible(
                  flex: 2,
                  child: Container(
                    width: Get.width,
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Colors.black38),
                        borderRadius: BorderRadius.all(Radius.circular(2.0))),
                    child: ExpandableNotifier(
                      // <-- Provides ExpandableController to its children
                      child: _buildInstallationUsages(
                          '--Select RJ-45 Connector--',
                          serviceTicketController.b2bInstallationUsages.value
                              .details!.rJ45Connector),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: LabelTextComponent(
                        text: 'Patch Cord', color: Colors.black, padding: 8.0)),
                Flexible(
                  flex: 2,
                  child: Container(
                    width: Get.width,
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Colors.black38),
                        borderRadius: BorderRadius.all(Radius.circular(2.0))),
                    child: ExpandableNotifier(
                      // <-- Provides ExpandableController to its children
                      child: _buildInstallationUsages(
                          '--Select Patch Cord--',
                          serviceTicketController
                              .b2bInstallationUsages.value.details!.patchCord),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: LabelTextComponent(
                        text: 'Media Converter',
                        color: Colors.black,
                        padding: 8.0)),
                Flexible(
                  flex: 2,
                  child: Container(
                    width: Get.width,
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Colors.black38),
                        borderRadius: BorderRadius.all(Radius.circular(2.0))),
                    child: ExpandableNotifier(
                      // <-- Provides ExpandableController to its children
                      child: _buildInstallationUsages(
                          '--Select Media Converter--',
                          serviceTicketController.b2bInstallationUsages.value
                              .details!.mediaConverter),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: LabelTextComponent(
                        text: 'SPF Module', color: Colors.black, padding: 8.0)),
                Flexible(
                  flex: 2,
                  child: Container(
                    width: Get.width,
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Colors.black38),
                        borderRadius: BorderRadius.all(Radius.circular(2.0))),
                    child: ExpandableNotifier(
                      // <-- Provides ExpandableController to its children
                      child: _buildInstallationUsages(
                          '--Select SPF Module--',
                          serviceTicketController
                              .b2bInstallationUsages.value.details!.sPFModule),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: LabelTextComponent(
                        text: 'SC Connector',
                        color: Colors.black,
                        padding: 8.0)),
                Flexible(
                  flex: 2,
                  child: Container(
                    width: Get.width,
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Colors.black38),
                        borderRadius: BorderRadius.all(Radius.circular(2.0))),
                    child: ExpandableNotifier(
                      // <-- Provides ExpandableController to its children
                      child: _buildInstallationUsages(
                          '--Select SC Connector--',
                          serviceTicketController.b2bInstallationUsages.value
                              .details!.sCConnector),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: LabelTextComponent(
                        text: 'Router', color: Colors.black, padding: 8.0)),
                Flexible(
                  flex: 2,
                  child: Container(
                    width: Get.width,
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Colors.black38),
                        borderRadius: BorderRadius.all(Radius.circular(2.0))),
                    child: ExpandableNotifier(
                      // <-- Provides ExpandableController to its children
                      child: _buildInstallationUsages(
                          '--Select Router--',
                          serviceTicketController
                              .b2bInstallationUsages.value.details!.router),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ))
      ],
    );
  }

  _buildB2CUsage() {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: LabelTextComponent(
                          text: 'Sr No.', color: Colors.black, padding: 8.0)),
                  Flexible(
                    flex: 2,
                    child: GetBuilder<ServiceTicketController>(
                      init: ServiceTicketController(),
                      builder: (controller) => TextFieldBoxDecorationComponent(
                        controller: controller.macIdController,
                        errorText: '',
                        hintText: '',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: LabelTextComponent(
                          text: 'Spliter No.',
                          color: Colors.black,
                          padding: 8.0)),
                  Flexible(
                    flex: 2,
                    child: GetBuilder<ServiceTicketController>(
                      init: ServiceTicketController(),
                      builder: (controller) => TextFieldBoxDecorationComponent(
                        controller: controller.deviceIdController,
                        errorText: '',
                        hintText: '',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: LabelTextComponent(
                          text: 'Port No.', color: Colors.black, padding: 8.0)),
                  Flexible(
                    flex: 2,
                    child: GetBuilder<ServiceTicketController>(
                      init: ServiceTicketController(),
                      builder: (controller) => TextFieldBoxDecorationComponent(
                        controller: controller.portNoController,
                        errorText: '',
                        hintText: '',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: LabelTextComponent(
                        text: 'Technical Issue',
                        color: Colors.black,
                        padding: 8.0),
                  ),

                  Flexible(
                    flex: 2,
                    child: DropDownButtonComponent(
                      itemsList: issueLists,
                      onChangedData: (IssueDatum value) {
                        debugPrint('DropdownValue${value.id}');
                        serviceTicketController
                            .updateTechnicalIssueValueID(value.id!);
                        if(value.name == "Other"){
                          serviceTicketController.isShowTechnicalIssueNote(true);
                        }
                        else{
                          serviceTicketController.isShowTechnicalIssueNote(false);
                        }
                      },
                      hintText: '--Select Issue--',
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 10,
              ),

              Obx((){
                if(serviceTicketController.isShowTechnicalIssueNote.value){
                  return
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          Expanded(
                              child: LabelTextComponent(
                                  text: 'Note', color: Colors.black, padding: 8.0)),
                          Flexible(
                            flex: 2,
                            child: GetBuilder<ServiceTicketController>(
                              init: ServiceTicketController(),
                              builder: (controller) => TextFieldBoxDecorationComponent(
                                controller: controller.technicalIssueNoteController,
                                errorText: '',
                                hintText: '',
                              ),
                            ),
                          ),
                        ],),

                        SizedBox(
                          height: 10,
                        ),

                      ],
                    );
                }
                else{
                  return Container();
                }
              }),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: LabelTextComponent(
                        text: 'Technical Resolution',
                        color: Colors.black,
                        padding: 8.0),
                  ),

                  Flexible(
                    flex: 2,
                    child: DropDownButtonComponent(
                      itemsList: resolutionLists,
                      onChangedData: (IssueDatum value) {
                        debugPrint('DropdownValue${value.id}');
                        serviceTicketController
                            .updateTechnicalResolutionValueID(value.id!);
                        if(value.name == "Other"){
                          serviceTicketController.isShowTechnicalResolutionNote(true);
                        }
                        else{
                          serviceTicketController.isShowTechnicalResolutionNote(false);
                        }
                      },
                      hintText: '--Select Resolution--',
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 10,
              ),

              Obx((){
                if(serviceTicketController.isShowTechnicalResolutionNote.value){
                  return
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          Expanded(
                              child: LabelTextComponent(
                                  text: 'Note', color: Colors.black, padding: 8.0)),
                          Flexible(
                            flex: 2,
                            child: GetBuilder<ServiceTicketController>(
                              init: ServiceTicketController(),
                              builder: (controller) => TextFieldBoxDecorationComponent(
                                controller: controller.technicalResolutionNoteController,
                                errorText: '',
                                hintText: '',
                              ),
                            ),
                          ),
                        ],),

                        SizedBox(
                          height: 10,
                        ),

                      ],
                    );
                }
                else{
                  return Container();
                }
              }),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: LabelTextComponent(
                        text: 'Status', color: Colors.black, padding: 8.0),
                  ),

                  Flexible(
                    flex: 2,
                    child: DropDownButtonComponent(
                      itemsList: statusLists,
                      onChangedData: (IssueDatum value) {
                        debugPrint('DropdownValue${value.id}');
                        serviceTicketController.updateStatusValueID(value.id!);
                      },
                      hintText: '--Select Status--',
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: LabelTextComponent(
                          text: 'Patch Cord',
                          color: Colors.black,
                          padding: 8.0)),
                  Flexible(
                    flex: 2,
                    child: Container(
                      width: Get.width,
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: Colors.black38),
                          borderRadius: BorderRadius.all(Radius.circular(2.0))),
                      child: ExpandableNotifier(
                        // <-- Provides ExpandableController to its children
                        child: _buildInstallationUsages(
                            '--Select Patch Cord--',
                            serviceTicketController.b2bInstallationUsages.value
                                .details!.patchCord),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: LabelTextComponent(
                          text: 'Cable Type',
                          color: Colors.black,
                          padding: 8.0)),
                  Flexible(
                    flex: 2,
                    child: Container(
                      width: Get.width,
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: Colors.black38),
                          borderRadius: BorderRadius.all(Radius.circular(2.0))),
                      child: ExpandableNotifier(
                          // <-- Provides ExpandableController to its children
                          child: _buildInstallationUsages(
                              '--Select Cable Type--',
                              serviceTicketController.b2bInstallationUsages
                                  .value.details!.cableType)),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: LabelTextComponent(
                          text: 'Joint Closure',
                          color: Colors.black,
                          padding: 8.0)),
                  Flexible(
                    flex: 2,
                    child: Container(
                      width: Get.width,
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: Colors.black38),
                          borderRadius: BorderRadius.all(Radius.circular(2.0))),
                      child: ExpandableNotifier(
                        // <-- Provides ExpandableController to its children
                        child: _buildInstallationUsages(
                            '--Select Joint Closure--',
                            serviceTicketController.b2bInstallationUsages.value
                                .details!.jointClosure),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: LabelTextComponent(
                          text: 'ONU', color: Colors.black, padding: 8.0)),
                  Flexible(
                    flex: 2,
                    child: Container(
                      width: Get.width,
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: Colors.black38),
                          borderRadius: BorderRadius.all(Radius.circular(2.0))),
                      child: ExpandableNotifier(
                        // <-- Provides ExpandableController to its children
                        child: _buildInstallationUsages(
                            '--Select ONU--',
                            serviceTicketController
                                .b2bInstallationUsages.value.details!.oNU),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: LabelTextComponent(
                          text: 'Sleeve', color: Colors.black, padding: 8.0)),
                  Flexible(
                    flex: 2,
                    child: Container(
                      width: Get.width,
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: Colors.black38),
                          borderRadius: BorderRadius.all(Radius.circular(2.0))),
                      child: ExpandableNotifier(
                        // <-- Provides ExpandableController to its children
                        child: _buildInstallationUsages(
                            '--Select Sleeve--',
                            serviceTicketController
                                .b2bInstallationUsages.value.details!.sleeves),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: LabelTextComponent(
                          text: 'SC Connector',
                          color: Colors.black,
                          padding: 8.0)),
                  Flexible(
                    flex: 2,
                    child: Container(
                      width: Get.width,
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: Colors.black38),
                          borderRadius: BorderRadius.all(Radius.circular(2.0))),
                      child: ExpandableNotifier(
                        // <-- Provides ExpandableController to its children
                        child: _buildInstallationUsages(
                            '--Select SC Connector--',
                            serviceTicketController.b2bInstallationUsages.value
                                .details!.sCConnector),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  _buildInstallationUsages(String selectType, List<dynamic>? itemsList) {
    Map<String, TextEditingController> textEditingControllers_list = {};
    List<String> field_list = [];

    Map<String, TextEditingController> textEditingControllers = {};
    var textEditingController = TextEditingController();

    List<String> field_name = [];

    Map.fromIterable(itemsList!,
        key: (e) => e.name,
        value: (e) => {
              textEditingController = new TextEditingController(),
              textEditingControllers.putIfAbsent(
                  e.name, () => textEditingController),
              field_name.add(e.name)
            });

    field_list = field_name;
    textEditingControllers_list = textEditingControllers;
    serviceTicketController.appendNewTextEditingController(
        textEditingControllers, field_name);

    print("CountNO${field_list.length}");

    print("Controller list${textEditingControllers_list}");

    return Column(
      children: [
        Expandable(
          // <-- Driven by ExpandableController from ExpandableNotifier
          collapsed: ExpandableButton(
            // <-- Expands when tapped on the cover photo
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectType,
                  style: TextStyle(fontSize: 10, color: Colors.black54),
                ),
                Icon(Icons.arrow_drop_down)
              ],
            ),
          ),
          expanded: Column(children: [
            ExpandableButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectType,
                    style: TextStyle(fontSize: 10, color: Colors.black54),
                  ),
                  Icon(Icons.arrow_drop_up)
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListView(
              shrinkWrap: true,
              children: <Widget>[
                for (var i in field_list)
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: GetBuilder<ServiceTicketController>(
                        init: ServiceTicketController(),
                        builder: (controller) =>
                            TextFieldWithLabelBoxDecorationComponent(
                          labelText: i,
                          controller: serviceTicketController
                              .textEditingControllers_list[i]!,
                          errorText: '',
                          hintText: 'N/A',
                        ),
                      )),
                    ],
                  ),
              ],
            ),
          ]),
        ),
      ],
    );
  }

  void onPressComplete() {
    serviceTicketController.postServiceTicketDataOnServer(
        HomeController.to.serviceTicketID, HomeController.to.serviceProfileID);
  }
}
