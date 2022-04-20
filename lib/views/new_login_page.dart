import 'package:flutter/material.dart';
import 'package:mjn_installer_app/components/button_component.dart';
import 'package:mjn_installer_app/components/text_field_component.dart';
import 'package:mjn_installer_app/controllers/home_controller.dart';
import 'package:mjn_installer_app/controllers/login_controller.dart';
import 'package:mjn_installer_app/res/colors.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';

class NewLoginPage extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final LoginController controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color(int.parse(MJNColors.bgColor)),
        body: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      height: screenHeight * 0.2,
                      child: Image(
                        image: AssetImage('assets/splash_screen_logo.png'),
                        width: 200,
                        height: 100,
                      )),
                  Center(
                    child: Container(
                      height: screenHeight * 0.6,
                      alignment: Alignment.center,
                      child: _buildWidget(),
                    ),
                  )
                ],
              ),
            )));
  }

  Widget _buildWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 150,
          width: Get.size.width * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Flexible(
                  child: Text(
                    'User Name:',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
                ),

                SizedBox(width: 20,),

                GetBuilder<LoginController>(
                    init: LoginController(),
                    builder: (controller) => Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: TextFieldComponent(
                              controller: controller.userIdController,
                              errorText: '',
                              hintText: '',
                            ),
                          ),
                        )),
              ]),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        'Password:',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                    ),
                    SizedBox(width: 14,),
                    GetBuilder<LoginController>(
                      init: LoginController(),
                      builder: (controller) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: TextFieldComponent(
                            controller: controller.passwordController,
                            errorText: '',
                            hintText: '',
                            icon: controller.isVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            isVisible: controller.isVisible,
                            onPress: controller.isVisibleStatus,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 35,
        ),
       Obx((){
         if(controller.isLoading.value){
          return Center(child: CircularProgressIndicator(),);
         }
         else {
          return ButtonComponent(
             text: 'Login',
             containerWidth: 120,
             padding: 10,
             color: Color(int.parse(MJNColors.buttonColor)),
             onPress: () => Get.find<LoginController>().login(),
           );
         }
       }) ,
        SizedBox(
          height: 10,
        ),
        Text(
          'forget password',
          style: TextStyle(decoration: TextDecoration.underline),
        ),
      ],
    );
  }
}
