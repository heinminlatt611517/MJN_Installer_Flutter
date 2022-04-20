import 'package:flutter/material.dart';
import 'package:mjn_installer_app/res/colors.dart';
import 'package:mjn_installer_app/utils/app_utils.dart';
import 'package:mjn_installer_app/widgets/build_pending_customer_complete_info.dart';
import 'package:get/get.dart';

class PendingCustomerCompletePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppUtils.customAppBar(),
      backgroundColor: Color(int.parse(MJNColors.bgColor)),
      body: _buildWidget(),
    );
  }

  Widget _buildWidget() {
    return Column(
      children: [
        SizedBox(
          height: 20.0,
        ),
        Text(
          'Pending Customer',
          style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 20,
              color: Colors.black,
              decoration: TextDecoration.none),
        ),
        SizedBox(
          height: 20.0,
        ),
        BuildPendingCustomerCompleteInfo(Get.arguments.toString()),

      ],
    );
  }

}
