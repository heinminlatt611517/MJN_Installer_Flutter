import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mjn_installer_app/controllers/home_controller.dart';
import 'package:mjn_installer_app/models/b2bAndb2cUsagesVO.dart';

import 'package:mjn_installer_app/models/serviceTicketDetailVO.dart';
import 'package:mjn_installer_app/network/RestApi.dart';
import 'package:mjn_installer_app/utils/app_constants.dart';
import 'package:mjn_installer_app/utils/app_utils.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ServiceTicketController extends GetxController {
  final readData = GetStorage();
  var serviceTicketDetail = ServiceTicketDetails().obs;
  var isLoading = false.obs;
  var loadingForButton = false.obs;
  var technicalIssueValueId;
  var technicalResolutionValueId;
  var statusValueId;

  var source = ImageSource.camera;
  var imagePicker;



  Map<String, TextEditingController> textEditingControllers_list = {};
  List<String> field_list = [];

  //manual text controller
  var macIdController = TextEditingController();
  var deviceIdController = TextEditingController();
  var portNoController = TextEditingController();

  //manual note text form controller
  var technicalIssueNoteController = TextEditingController();
  var technicalResolutionNoteController = TextEditingController();

  var isShowTechnicalIssueNote = false.obs;
  var isShowTechnicalResolutionNote = false.obs;

  var b2bInstallationUsages = B2BAndB2CUsagesVo().obs;

  @override
  void onInit() {
    imagePicker = new ImagePicker();
    super.onInit();
  }


  //
  String? str_image_onu_front_side = null;
  String? str_image_onu_back_side = null;

  String? str_image_odb_before = null;
  String? str_image_odb_after = null;

  String? str_image_spliter_before = null;
  String? str_image_spliter_after = null;

  String? str_imageAcceptForm = null;

//
  File? image_onu_front_side;
  File? image_onu_back_side;

  File? image_odb_before;
  File? image_odb_after;

  File? image_spliter_before;
  File? image_spliter_after;

  File? imageAcceptForm;


  void updateTechnicalIssueValueID(int id) {
    technicalResolutionValueId = id;
    update();
  }

  void updateTechnicalResolutionValueID(int id) {
    technicalIssueValueId = id;
    update();
  }

  void updateStatusValueID(int id) {
    statusValueId = id;
    update();
  }

  void onUIReady(String ticketID) {
    fetchServiceTicketDetail(ticketID);
  }

  void onTapONUFrontSide(BuildContext context) {

    _showChoiceDialog(context, 'onu_front');
  }

  void onTapONUBackSide(BuildContext context) {

    _showChoiceDialog(context, 'onu_back');
  }

  void onTapODBBefore(BuildContext context) {

    _showChoiceDialog(context, 'odb_before');
  }

  void onTapODBAfter(BuildContext context) {

    _showChoiceDialog(context, 'odb_after');
  }

  void onTapSpliterBefore(BuildContext context) {

    _showChoiceDialog(context, 'spliter_before');
  }

  void onTapSpliterAfter(BuildContext context) {

    _showChoiceDialog(context, 'spliter_after');
  }

  void onTapAcceptForm(BuildContext context) {

    _showChoiceDialog(context, 'accept');
  }

  void imageFromGallery(String tapStatus) async {
    XFile? image = await imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        preferredCameraDevice: CameraDevice.front);

    //ONU IMAGE
    if (tapStatus == 'onu_front') {
      image_onu_front_side = File(image!.path);
      str_image_onu_front_side =
          base64Encode(File(image.path).readAsBytesSync());
      debugPrint('onuFront::${str_image_onu_front_side}');
      update();
    } else if (tapStatus == 'onu_back') {
      image_onu_back_side = File(image!.path);
      str_image_onu_back_side =
          base64Encode(File(image.path).readAsBytesSync());
      debugPrint('onuBack::${str_image_onu_back_side}');
      update();
    }
    //ODB IMAGE
    else if (tapStatus == 'odb_before') {
      image_odb_before = File(image!.path);
      str_image_odb_before = base64Encode(File(image.path).readAsBytesSync());
      update();
    } else if (tapStatus == 'odb_after') {
      image_odb_after = File(image!.path);
      str_image_odb_after = base64Encode(File(image.path).readAsBytesSync());
      update();
    }

    // Spliter Image

    else if (tapStatus == 'spliter_before') {
      image_spliter_before = File(image!.path);
      str_image_spliter_before =
          base64Encode(File(image.path).readAsBytesSync());
      update();
    } else if (tapStatus == 'spliter_after') {
      image_spliter_after = File(image!.path);
      str_image_spliter_after =
          base64Encode(File(image.path).readAsBytesSync());
      update();
    } else {
      imageAcceptForm = File(image!.path);
      str_imageAcceptForm = base64Encode(File(image.path).readAsBytesSync());
      update();
    }
  }

  void imageFromCamera(String tapStatus) async {
    XFile? image = await imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
        preferredCameraDevice: CameraDevice.front);

    //ONU IMAGE
    if (tapStatus == 'onu_front') {
      image_onu_front_side = File(image!.path);
      str_image_onu_front_side =
          base64Encode(File(image.path).readAsBytesSync());
      debugPrint('onuFront::${str_image_onu_front_side}');
      update();
    } else if (tapStatus == 'onu_back') {
      image_onu_back_side = File(image!.path);
      str_image_onu_back_side =
          base64Encode(File(image.path).readAsBytesSync());
      debugPrint('onuBack::${str_image_onu_back_side}');
      update();
    }
    //ODB IMAGE
    else if (tapStatus == 'odb_before') {
      image_odb_before = File(image!.path);
      str_image_odb_before = base64Encode(File(image.path).readAsBytesSync());
      update();
    } else if (tapStatus == 'odb_after') {
      image_odb_after = File(image!.path);
      str_image_odb_after = base64Encode(File(image.path).readAsBytesSync());
      update();
    }

    // Spliter Image

    else if (tapStatus == 'spliter_before') {
      image_spliter_before = File(image!.path);
      str_image_spliter_before =
          base64Encode(File(image.path).readAsBytesSync());
      update();
    } else if (tapStatus == 'spliter_after') {
      image_spliter_after = File(image!.path);
      str_image_spliter_after =
          base64Encode(File(image.path).readAsBytesSync());
      update();
    } else {
      imageAcceptForm = File(image!.path);
      str_imageAcceptForm = base64Encode(File(image.path).readAsBytesSync());
      update();
    }
  }

  void appendNewTextEditingController(
      Map<String, TextEditingController> textEditingController,
      List<String> field_name) {
    textEditingControllers_list.addAll(textEditingController);
    field_list.addAll(field_name);
  }

  void fetchServiceTicketDetail(String ticketID) {
    isLoading(true);
    RestApi.getServiceTicketDetail(
        readData.read(TOKEN), readData.read(UID), ticketID)
        .then((value) {
      if (value.status == 'Success') {
        serviceTicketDetail.value = value.details!;
        RestApi.fetchInstallationUsages(
            readData.read(TOKEN),
            readData.read(UID),
            HomeController.to.serviceCustomerType == 'b2b' ? 'b2b' : 'b2c')
            .then((value) =>
        {b2bInstallationUsages.value = value, isLoading(false)});
      } else {
        isLoading(false);
      }
    });
  }

  Future<void> postServiceTicketDataOnServer(String ticketID, String profileID) async {
    loadingForButton(true);

    var firstMap = {
      'uid': readData.read(UID),
      'profile_id': profileID,
      'ticket_id': ticketID,
      'app_version': app_version,
      'customer_type': HomeController.to.serviceCustomerType,
      'customer_uid': HomeController.to.serviceCustomerUid,
      'sr_no': macIdController.value.text.toString(),
      'spliter_no': deviceIdController.value.text.toString(),
      'port_no': portNoController.value.text.toString(),
      'status': statusValueId.toString(),
      'technical_issue': technicalIssueValueId ?? 0,
      'technical_issue_other':
      technicalIssueNoteController.text.toString() == ""
          ? "null"
          : technicalIssueNoteController.text.toString(),
      'technical_resolution': technicalResolutionValueId ?? 0,
      'technical_resolution_other':
      technicalResolutionNoteController.text.toString() == ""
          ? "null"
          : technicalResolutionNoteController.text.toString(),
      'front_onu_img': str_image_onu_front_side ?? null,
      'back_onu_img': str_image_onu_back_side ?? null,
      'before_odb_img': str_image_odb_before ?? null,
      'after_odb_img': str_image_odb_after ?? null,
      'before_spliter_img': str_image_spliter_before ?? null,
      'after_spliter_img': str_image_spliter_after ?? null,
      'service_acceptance_img': str_imageAcceptForm ?? null,
    };

    var secondMap = {
      for (var item in field_list)
        '$item':
        '${textEditingControllers_list[item]?.text == ''
            ? '0'
            : textEditingControllers_list[item]?.text}'
    };

    var thirdMap = {};

    thirdMap.addAll(firstMap);
    thirdMap.addAll(secondMap);

    debugPrint("Usage map collection::${thirdMap}", wrapWidth: 1024);

    if (str_image_onu_front_side == null ||
        str_image_onu_back_side == null ||
        str_image_odb_before == null ||
        str_image_odb_after == null ||
        str_image_spliter_before == null ||
        str_image_spliter_after == null ||
        str_imageAcceptForm == null) {
      loadingForButton(false);
      AppUtils.showErrorSnackBar("Fail", 'Please select a photo!');

    }


    else if (statusValueId == null) {
      loadingForButton(false);
      AppUtils.showErrorSnackBar("Fail", 'Please select a status!');
    }

    else {

      var list = field_list.where((element) => textEditingControllers_list[element]!.text.isEmpty).toList();

      if(list.isNotEmpty)
      {
        loadingForButton(false);
        AppUtils.showErrorSnackBar("Fail", 'Please enter all usages data!');
      }else {
        RestApi.postServiceTicketData(thirdMap, readData.read(TOKEN))
            .then((value) =>
        {
          if (value.status == 'Success')
            {
              loadingForButton(false),
              Get.offNamed(PENDING_CUSTOMER_COMPLETE_PAGE,
                  arguments: ticketID)
            }
          else
            {loadingForButton(false)}
        });
      }

    }
  }


  Future<void> _showChoiceDialog(BuildContext context, String status) {
    return showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Choose option", style: TextStyle(color: Colors.blue),),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Divider(height: 1, color: Colors.blue,),
              ListTile(
                onTap: () {
                 imageFromGallery(status);
                 Navigator.pop(context);
                },
                title: Text("Gallery"),
                leading: Icon(Icons.account_box, color: Colors.blue,),
              ),

              Divider(height: 1, color: Colors.blue,),
              ListTile(
                onTap: () {
                 imageFromCamera(status);
                 Navigator.pop(context);
                },
                title: Text("Camera"),
                leading: Icon(Icons.camera, color: Colors.blue,),
              ),
            ],
          ),
        ),);
    });
  }

}