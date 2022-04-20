import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:mjn_installer_app/controllers/home_controller.dart';
import 'package:mjn_installer_app/controllers/page_argument_controller.dart';
import 'package:mjn_installer_app/utils/app_constants.dart';

class BottomNavigationBarComponent extends StatelessWidget {
  BottomNavigationBarComponent(
      {Key? key, required this.argumentData, required this.onChangedData})
      : super(key: key);
  late String argumentData;
  final void Function(String) onChangedData;

  @override
  Widget build(BuildContext context) {
    debugPrint("ArgumentData${argumentData}");
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Stack(
            children: [
              InkWell(
                onTap: () {
                  PageArgumentController.to.updateArgumentData(INSTALLATION);
                  onChangedData(INSTALLATION);
                },
                child: Container(
                  padding: EdgeInsets.only(right: 1, top: 10),
                  height: 52,
                  width: 150,
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: argumentData == INSTALLATION
                            ? Color(0xffFF5F1F)
                            : Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(12.0))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Installation',
                          style: TextStyle(color: Colors.white),
                        ),
                        Image.asset("assets/installation_img.png",color: Colors.white,height: 50,)
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 1,
                right: 2,
                child: Container(
                  padding: const EdgeInsets.all(6.0),
                  decoration: const BoxDecoration(
                      color: Colors.red, shape: BoxShape.circle),
                  child: Text(
                    HomeController.to.serviceTicketAndInstallationCounts.value
                        .allInstallationCounts
                        .toString(),
                    style: TextStyle(
                        fontSize: 8,
                        color: Colors.white,
                        decoration: TextDecoration.none),
                  ),
                ),
              ),
            ],
          ),
          Stack(
            children: [
              InkWell(
                onTap: () {
                  PageArgumentController.to.updateArgumentData(SERVICE_TICKET);
                  onChangedData(SERVICE_TICKET);
                },
                child: Container(
                  padding: EdgeInsets.only(right: 1, top: 10),
                  height: 52,
                  width: 150,
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: argumentData == SERVICE_TICKET
                            ? Color(0xffFF5F1F)
                            : Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(12.0))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Service Ticket',
                          style: TextStyle(color: Colors.white),
                        ),
                        Image.asset("assets/service_ticket_img.png",color: Colors.white,height: 50,)
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 1,
                right: 2,
                child: Container(
                  padding: const EdgeInsets.all(6.0),
                  decoration: const BoxDecoration(
                      color: Colors.red, shape: BoxShape.circle),
                  child: Obx((){
                    return Text(
                      HomeController.to
                          .serviceTicketAndInstallationCounts.value
                          .allServiceTicketsCounts.toString() ,
                      style: TextStyle(
                          fontSize: 8,
                          color: Colors.white,
                          decoration: TextDecoration.none),
                    );})
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
