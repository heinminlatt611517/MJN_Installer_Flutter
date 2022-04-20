import 'package:flutter/material.dart';
import 'package:mjn_installer_app/res/colors.dart';
import 'package:mjn_installer_app/utils/app_constants.dart';
import 'package:mjn_installer_app/utils/app_utils.dart';
import 'package:mjn_installer_app/widgets/build_complete_customer_list.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';


class CompleteCustomerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Get.back();
        Get.toNamed(TICKET_STATUS_PAGE);
        return Future.value(false);
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            backgroundColor: Color(int.parse(MJNColors.bgColor)),
            appBar: AppUtils.customAppBar(),
            body: Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
              child: BuildCompleteCustomerList()
            ),
            ),
      ),
    );
  }
}
