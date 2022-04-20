import 'package:flutter/material.dart';
import 'package:mjn_installer_app/controllers/home_controller.dart';
import 'package:mjn_installer_app/controllers/page_argument_controller.dart';
import 'package:mjn_installer_app/utils/app_constants.dart';
import 'package:get/get.dart';

class TicketStatusComponent extends StatelessWidget {
  TicketStatusComponent(
      {Key? key,
        this.text,
        this.color,
        this.padding,
        required this.status,
        required this.routeName,
        this.icon,
        this.containerWidth,
        this.onPress,
        this.count,
        this.argumentData,
        this.assertImage})
      : super(key: key);
  final String? text;
  final Function()? onPress;
  final Color? color;
  final double? padding;
  final double? containerWidth;
  final String status;
  final String routeName;
  final IconData? icon;
  final String? count;
  final String? argumentData;
  final String? assertImage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        PageArgumentController.to.updateArgumentData(argumentData!),
        status == NEW_ORDER
            ? PageArgumentController.to.updateStatus(NEW_ORDER)
            : PageArgumentController.to.updateStatus(PENDING),
        Get.toNamed(routeName)!.then((value) {
          HomeController.to
              .fetchAllCountsForServiceTicketAndInstallation(context);
          debugPrint('fetch all counts');
        }),

        status == NEW_ORDER
            ? PageArgumentController.to.updateStatusTitle(NEW_ORDER)
            : PageArgumentController.to.updateStatusTitle(PENDING)

      },
      child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(right: 1, top: 15),
              child: Container(
                height: 50.0,
                 padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12.0))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text(status,style: TextStyle(fontWeight: FontWeight.bold,
                  color: Colors.black),),

                  SizedBox(width: 10,),

                  Image.asset(
                    assertImage!,
                    height: 20.0,
                  ),

                ],),
              ),
            ),
            Positioned(
              top: 1,
              right: 2,
              child: Container(
                alignment: Alignment.center,
                width: 25,
                height: 30,
                decoration: const BoxDecoration(
                    color: Colors.red, shape: BoxShape.circle),
                child: Text(
                  count != null ? count! : '0',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      decoration: TextDecoration.none),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
      ),
    );
  }
}
