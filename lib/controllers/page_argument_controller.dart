import 'package:get/get.dart';
import 'package:mjn_installer_app/utils/app_constants.dart';

class PageArgumentController extends GetxController{
  String argumentData = '';
  String d_status = '';
  String c_status_title = '';
  String customer_status = '';
  var isShowStatus = false.obs;

  static PageArgumentController get to => Get.find();

  void updateArgumentData(String argument){
    argumentData = argument;
    if(argument == INSTALLATION){
      isShowStatus(false);
    }
    else{
      isShowStatus(true);
    }
    update();
  }

  String getCustomerStatus(){
    return customer_status;
  }

  void updateCustomerStatus(String status){
    customer_status = status;
    update();
  }

  void updateStatus(String status){
    d_status = status;
    update();
  }

  String getArgumentData(){
    return argumentData;
  }

  void updateStatusTitle(String status){
    c_status_title = status;
    update();
  }

  String getStatusTitle(){
    return c_status_title;
  }


  String getStatus(){
    return d_status;
  }
}