import 'package:get/get.dart';

class TicketStatusController extends GetxController{
  String argumentData = '';

  void updateArgumentData(String argument){
    argumentData = argument;
    update();
  }

  String getArgumentData(){
    return argumentData;
  }

  void fetchInstallationData(){

  }

  void fetchServiceTicketData(){

  }

}