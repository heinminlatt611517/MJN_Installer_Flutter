import 'package:flutter/material.dart';
import 'package:mjn_installer_app/controllers/login_controller.dart';
import 'package:mjn_installer_app/controllers/page_argument_controller.dart';
import 'package:mjn_installer_app/res/colors.dart';
import 'package:mjn_installer_app/utils/app_constants.dart';
import 'package:mjn_installer_app/utils/app_utils.dart';
import 'package:mjn_installer_app/widgets/build_installation_dropdown_list.dart';
import 'package:mjn_installer_app/widgets/build_maintenance_dropdown_list.dart';
import 'package:get/get.dart';

class CustomerIssuePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if(LoginController.to.maintenanceDropDownListsData == null){
      LoginController.to.fetchAllDropDownListsAndSaveToSharePref();
    }
    return Scaffold(
      appBar: AppUtils.customAppBar(),
      backgroundColor: Color(int.parse(MJNColors.bgColor)),
      body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildWidget(),
          )),
    );
  }

  Widget _buildWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 10.0,
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
          //BuildCustomerInfoLabel(),
          PageArgumentController.to.getArgumentData() == INSTALLATION
              ? BuildInstallationDropdownList()
              : BuildMaintenanceDropdownList(),
        ],
      ),
    );
  }
}
