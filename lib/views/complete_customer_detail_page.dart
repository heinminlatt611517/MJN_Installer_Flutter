import 'package:flutter/material.dart';
import 'package:mjn_installer_app/controllers/customer_detail_controller.dart';
import 'package:mjn_installer_app/res/colors.dart';
import 'package:mjn_installer_app/utils/app_utils.dart';
import 'package:mjn_installer_app/widgets/build_customer_detail_info.dart';
import 'package:get/get.dart';

class CompleteCustomerDetailPage extends StatefulWidget {
  @override
  State<CompleteCustomerDetailPage> createState() => _CompleteCustomerDetailPageState();
}

class _CompleteCustomerDetailPageState extends State<CompleteCustomerDetailPage> {

  @override
  void initState() {
    Get.put(CustomerDetailController());
    super.initState();
  }

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
          'Complete Customer',
          style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 20,
              color: Colors.black,
              decoration: TextDecoration.none),
        ),
        SizedBox(
          height: 20.0,
        ),
        BuildCustomerDetailInfo(
            Get.arguments.toString(),status: 'complete',),
      ],
    );
  }
}
