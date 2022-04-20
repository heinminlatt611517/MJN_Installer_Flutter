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
import 'package:mjn_installer_app/controllers/installation_controller.dart';
import 'package:mjn_installer_app/controllers/login_controller.dart';
import 'package:mjn_installer_app/models/allDropDownListVO.dart';
import 'package:mjn_installer_app/res/colors.dart';
import 'package:get/get.dart';

class BuildInstallationDropdownList extends StatefulWidget {
  @override
  State<BuildInstallationDropdownList> createState() =>
      _BuildInstallationDropdownListState();
}

class _BuildInstallationDropdownListState
    extends State<BuildInstallationDropdownList> {
  final InstallationController installationController =
      Get.put(InstallationController());
  List<InstallationStatus>? installationStatusLists;

  @override
  void initState() {
    installationController.onUIReady();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    installationStatusLists = LoginController
        .to.maintenanceDropDownListsData.details!.installationStatus!;
    return Obx(() {
      if (installationController.isLoading.value) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                customerLabel,
                middleLabel,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LabelTextComponent(
                        text: installationController
                                .installationDetail.value.user_name ??
                            "xx xxx xxx xxx xxx",
                        color: Colors.black,
                        padding: 8.0),
                    LabelTextComponent(
                        text: installationController
                                .installationDetail.value.odb_name ??
                            "xx xxx xxx xxx xxx",
                        color: Colors.black,
                        padding: 8.0),
                    LabelTextComponent(
                        text: installationController
                                        .installationDetail.value.latitude ==
                                    null &&
                                installationController
                                        .installationDetail.value.longitude ==
                                    null
                            ? "xx xxx xxx xxx xxx"
                            : installationController
                                    .installationDetail.value.latitude! +
                                "," +
                                installationController
                                    .installationDetail.value.longitude!,
                        color: Colors.black,
                        padding: 8.0),
                    LabelTextComponent(
                        text: (installationController.installationDetail.value
                                        .gateway_ip ==
                                    null ||
                                installationController.installationDetail
                                        .value.gateway_ip ==
                                    "")
                            ? "xx xxx xxx xxx xxx"
                            : installationController
                                .installationDetail.value.gateway_ip!,
                        color: Colors.black,
                        padding: 8.0),
                    LabelTextComponent(
                        text: (installationController.installationDetail.value
                                        .customer_ip ==
                                    "" ||
                                installationController.installationDetail
                                        .value.customer_ip ==
                                    null)
                            ? "xx xxx xxx xxx xxx"
                            : installationController
                                .installationDetail.value.customer_ip!,
                        color: Colors.black,
                        padding: 8.0),
                    LabelTextComponent(
                        text: (installationController.installationDetail.value
                                        .network_address ==
                                    "" ||
                                installationController.installationDetail
                                        .value.network_address ==
                                    null)
                            ? "xx xxx xxx xxx xxx"
                            : installationController
                                .installationDetail.value.network_address!,
                        color: Colors.black,
                        padding: 8.0),
                    LabelTextComponent(
                        text: (installationController.installationDetail.value
                                        .user_cvlan ==
                                    "" ||
                                installationController.installationDetail
                                        .value.user_cvlan ==
                                    null)
                            ? "xx xxx xxx xxx xxx"
                            : installationController
                                .installationDetail.value.user_cvlan!,
                        color: Colors.black,
                        padding: 8.0),
                    LabelTextComponent(
                        text: (installationController.installationDetail.value
                                        .user_svlan ==
                                    "" ||
                                installationController.installationDetail
                                        .value.user_svlan ==
                                    null)
                            ? "xx xxx xxx xxx xxx"
                            : installationController
                                .installationDetail.value.user_svlan!,
                        color: Colors.black,
                        padding: 8.0),
                  ],
                )
              ],
            ),
            Container(
              width: Get.width,
              margin: EdgeInsets.only(left: 24.0, right: 24.0),
              child: HomeController.to.installationCustomerType == 'b2b'
                  ? _buildB2BUsage()
                  : _buildB2CUsage(),
            ),
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Remote Login Function'),
                GetBuilder<InstallationController>(
                  builder: (controller) => Checkbox(
                    value: controller.checkBoxValue,
                    onChanged: (value) => controller
                        .updateCheckBoxValue(value!), //  <-- leading Checkbox
                  ),
                )
              ],
            ),
            SizedBox(
              height: 40.0,
            ),
            Obx(() {
              if (installationController.loadingForButton.value) {
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
      }
    });
  }

  Widget choosePhotoListsWidget(BuildContext context) {
    return
    Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text('ONU Image'),
      SizedBox(
        height: 10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GetBuilder<InstallationController>(
            builder: (controller) => PhotoPickerComponent(
              imagePath: controller.image_onu_front_side,
              text: 'Front Side',
              onPress: () => {controller.onTapONUFrontSide(context)},
            ),
          ),
          SizedBox(
            width: 20,
          ),
          GetBuilder<InstallationController>(
            builder: (controller) => PhotoPickerComponent(
              imagePath: controller.image_onu_back_side,
              text: 'Back Side',
              onPress: () => {controller.onTapONUBackSide(context)},
            ),
          ),
        ],
      ),
      SizedBox(
        height: 20,
      ),
      Text('ODB Image'),
      SizedBox(
        height: 10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GetBuilder<InstallationController>(
            builder: (controller) => PhotoPickerComponent(
              imagePath: controller.image_odb_before,
              text: 'Before ODB Photo',
              onPress: () => {controller.onTapODBBefore(context)},
            ),
          ),
          SizedBox(
            width: 20,
          ),
          GetBuilder<InstallationController>(
            builder: (controller) => PhotoPickerComponent(
              imagePath: controller.image_odb_after,
              text: 'After ODB Photo',
              onPress: () => {controller.onTapODBAfter(context)},
            ),
          ),
        ],
      ),
      SizedBox(
        height: 20,
      ),
      Text('Spliter Image'),
      SizedBox(
        height: 10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GetBuilder<InstallationController>(
            builder: (controller) => PhotoPickerComponent(
              imagePath: controller.image_spliter_before,
              text: 'Before Spliter Photo',
              onPress: () => {controller.onTapSpliterBefore(context)},
            ),
          ),
          SizedBox(
            width: 20,
          ),
          GetBuilder<InstallationController>(
            builder: (controller) => PhotoPickerComponent(
              imagePath: controller.image_spliter_after,
              text: 'After Spliter Photo',
              onPress: () => {controller.onTapSpliterAfter(context)},
            ),
          ),
        ],
      ),
      SizedBox(
        height: 20,
      ),
      Text('Service Acceptance Form'),
      GetBuilder<InstallationController>(
        builder: (controller) => PhotoPickerComponent(
          imagePath: controller.imageAcceptForm,
          text: '',
          onPress: () => {controller.onTapAcceptForm(context)},
        ),
      ),
    ],
  );
    }

  final customerLabel = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      LabelTextComponent(text: 'User ID', color: Colors.black, padding: 8.0),
      LabelTextComponent(text: 'ODB Name', color: Colors.black, padding: 8.0),
      LabelTextComponent(
          text: 'ODB Lat/Log', color: Colors.black, padding: 8.0),
      LabelTextComponent(text: 'Gateway IP', color: Colors.black, padding: 8.0),
      LabelTextComponent(
          text: 'Customer IP', color: Colors.black, padding: 8.0),
      LabelTextComponent(
          text: 'Network Address', color: Colors.black, padding: 8.0),
      LabelTextComponent(
          text: 'User C.VIan', color: Colors.black, padding: 8.0),
      LabelTextComponent(
          text: 'User S.VIan', color: Colors.black, padding: 8.0),
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
                  child: GetBuilder<InstallationController>(
                    init: InstallationController(),
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
                  child: GetBuilder<InstallationController>(
                    init: InstallationController(),
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
                  child: GetBuilder<InstallationController>(
                    init: InstallationController(),
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
                LabelTextComponent(
                    text: 'Status', color: Colors.black, padding: 8.0),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: DropDownButtonComponent(
                    itemsList: installationStatusLists,
                    onChangedData: (InstallationStatus value) {
                      debugPrint('DropdownValue${value.id}');
                      installationController.updateStatusValueID(value.id!);

                      if (value.id == 3 || value.id == 6) {
                        installationController.selectDate(context);
                        }
                    },
                    hintText: '--Select Status--',
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Obx((){
              if(installationController.isShowNoteTextFormField.value){
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
                          child: GetBuilder<InstallationController>(
                            init: InstallationController(),
                            builder: (controller) => TextFieldBoxDecorationComponent(
                              controller: controller.statusCancelAndIncompleteTextController,
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
                            installationController.b2bInstallationUsages.value
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
                          installationController.b2bInstallationUsages.value
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
                          installationController
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
                          installationController
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
                          installationController
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
                          installationController.b2bInstallationUsages.value
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
                          installationController
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
                          installationController.b2bInstallationUsages.value
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
                          installationController
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
                          installationController.b2bInstallationUsages.value
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
                          installationController
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
                    child: GetBuilder<InstallationController>(
                      init: InstallationController(),
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
                    child: GetBuilder<InstallationController>(
                      init: InstallationController(),
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
                    child: GetBuilder<InstallationController>(
                      init: InstallationController(),
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
                  LabelTextComponent(
                      text: 'Status', color: Colors.black, padding: 8.0),
                  SizedBox(
                    width: 50,
                  ),
                  Expanded(
                    child: DropDownButtonComponent(
                      itemsList: installationStatusLists,
                      onChangedData: (InstallationStatus value) {
                        debugPrint('DropdownValue${value.id}');

                        installationController.updateStatusValueID(value.id!);
                        if (value.id == 3 || value.id == 6) {
                          installationController.selectDate(context);
                        }
                      },
                      hintText: '--Select Status--',
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),

             Obx((){
               if(installationController.isShowNoteTextFormField.value){
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
                           child: GetBuilder<InstallationController>(
                             init: InstallationController(),
                             builder: (controller) => TextFieldBoxDecorationComponent(
                               controller: controller.statusCancelAndIncompleteTextController,
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
                              installationController.b2bInstallationUsages.value
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
                            installationController.b2bInstallationUsages.value
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
                            installationController
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
                            installationController
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
                            installationController.b2bInstallationUsages.value
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
    installationController.appendNewTextEditingController(
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
                          child: GetBuilder<InstallationController>(
                        init: InstallationController(),
                        builder: (controller) =>
                            TextFieldWithLabelBoxDecorationComponent(
                          labelText: i,
                          controller: installationController
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
    installationController.postInstallationDataOnServer();
  }
}
