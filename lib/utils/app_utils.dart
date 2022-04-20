import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mjn_installer_app/res/colors.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:store_redirect/store_redirect.dart';
import 'app_constants.dart';

class AppUtils {
  static void showErrorSnackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
      icon: Icon(Icons.error, color: Colors.black),
      backgroundColor: Colors.red,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
    );
  }

  static  showSuccessSnackBar(String title, String message)  {
    Get.snackbar(
      title,
      message,
      icon: Icon(Icons.error, color: Colors.black),
      backgroundColor: Colors.green,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
    );
  }

  static AppBar customAppBar() {
    return AppBar(
        toolbarHeight: 100,
        elevation: 0,
        backgroundColor: Color(int.parse(MJNColors.bgColor)),
        title: Container(
          alignment: Alignment.center,
          child: Image(
            image: AssetImage('assets/splash_screen_logo.png'),
            width: 200,
            height: 100,
          ),
        ),);
  }


  static Future<void> removeDataFromGetStorage() async {
    final box = GetStorage();
    box.remove(TOKEN);
    box.remove(UID);
    box.remove(ALL_DROP_DOWN_LISTS);
    box.remove(SAVE_TIME);
  }

  static void showSessionExpireDialog(
      String title, String message, BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (_) => Center(
                child: SafeArea(
                  child: Container(
                    height: 270,
                    width: double.infinity,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(4),
                    color: Color(int.parse(MJNColors.bgColor)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 60,
                          color: Colors.black,
                        ),
                        Center(
                          child: Text(
                            title,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.none,
                                fontSize: 20.0),
                          ),
                        ),
                        Center(
                          child: Text(
                            message,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.5555,
                            height: MediaQuery.of(context).size.height * 0.0625,
                            child: RaisedButton(
                                color: Colors.white,
                                child: Text(
                                  'OK',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                onPressed: () {
                                  Get.back();
                                  AppUtils.removeDataFromGetStorage().then(
                                      (value) => {Get.offAllNamed(LOGIN)});
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
    });
  }

  static void showRequireUpdateDialog(
      String title, String message, BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (_) => Center(
            child: Container(
              height: 270,
              width: double.infinity,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(4),
              color: Color(int.parse(MJNColors.bgColor)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.update,
                    size: 60,
                    color: Color(0xff188FC5),
                  ),
                  Center(
                    child: Text(
                      title,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.black,
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  Center(
                    child: Text(
                      message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          color:Colors.black,decoration: TextDecoration.none),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: 100,
                          height: 40,
                          child: RaisedButton(
                              child: Text(
                                'Ignore',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              onPressed: () {
                                Get.back();
                              }),
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          height: 40,
                          child: RaisedButton(
                              child: Text(
                                'Update Now',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              onPressed: () {
                                StoreRedirect.redirect(androidAppId: 'com.moc.mjninstaller',iOSAppId: '');
                              }),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ));
    });
  }



}
