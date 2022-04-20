import 'package:flutter/material.dart';
import 'package:mjn_installer_app/models/allDropDownListVO.dart';
import 'package:mjn_installer_app/network/RestApi.dart';
import 'package:mjn_installer_app/utils/app_constants.dart';
import 'package:mjn_installer_app/utils/app_utils.dart';
import 'package:mjn_installer_app/views/home_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';

class LoginController extends GetxController {
  var userIdController = TextEditingController();
  var passwordController = TextEditingController();
  var isVisible = true;
  dynamic maintenanceDropDownListsData;
  final writeData = GetStorage();
  var isLoading = false.obs;

  static LoginController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    fetchAllDropDownListsAndSaveToSharePref();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onClose() {
    super.onClose();
  }



  @override
  void onReady() {
    super.onReady();
  }

  void clearText(){
    userIdController.text = '';
    passwordController.text = '';
    update();
  }

  void login() {
    {
      debugPrint('click');
      if (userIdController.text != '' || passwordController.text != '') {
        isLoading(true);
        Map<String, String> map = {
          'user_id': userIdController.value.text,
          'password': passwordController.value.text
        };

        debugPrint('call api');
        RestApi.fetchSupportLogin(map).then((value) => {
              Future.delayed(Duration.zero, () {
                if (value.status == 'Success') {
                  clearText();
                  writeData.write(TOKEN, value.token);
                  writeData.write(UID, value.uid);
                  isLoading(false);
                  Get.off(HomePage());
                } else {
                  isLoading(false);
                  AppUtils.showErrorSnackBar("Fail", value.description ?? '');
                }
              })
            });
      } else {
        isLoading(false);
      }
    }
  }

  void fetchAllDropDownListsAndSaveToSharePref() {
    RestApi.fetchAllDropDownLists().then((value) {

        debugPrint(
            "DDLLists${allDropDownListVoFromJson(json.decode(writeData.read(ALL_DROP_DOWN_LISTS))).details}");
        maintenanceDropDownListsData = allDropDownListVoFromJson(
            json.decode(writeData.read(ALL_DROP_DOWN_LISTS)));
        update();


    });
  }

  void isVisibleStatus() {
    isVisible = !isVisible;
    update();
  }
}
