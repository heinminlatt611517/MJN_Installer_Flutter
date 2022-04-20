import 'package:mjn_installer_app/views/complete_customer_detail_page.dart';
import 'package:mjn_installer_app/views/my_location_page.dart';
import 'package:mjn_installer_app/views/pending_customer_complete_page.dart';
import 'package:mjn_installer_app/views/complete_customer_page.dart';
import 'package:mjn_installer_app/views/customer_detail_page.dart';
import 'package:mjn_installer_app/views/customer_issue_page.dart';
import 'package:mjn_installer_app/views/customer_status_page.dart';
import 'package:mjn_installer_app/views/home_page.dart';
import 'package:mjn_installer_app/views/new_login_page.dart';
import 'package:mjn_installer_app/views/new_order_customer_page.dart';
import 'package:mjn_installer_app/views/ticket_status_page.dart';
import 'package:get/get.dart';

import 'app_constants.dart';

class Routers{
  static final route = [
    GetPage(name: LOGIN, page: () => NewLoginPage()),
    GetPage(name: HOME, page: () => HomePage()),
    GetPage(name: TICKET_STATUS_PAGE, page: () => TicketStatusPage()),
    GetPage(name: CUSTOMER_STATUS_PAGE, page: () => CustomerStatusPage()),
    GetPage(name: CUSTOMER_DETAIL_PAGE, page: () => CustomerDetailPage()),
    GetPage(name: CUSTOMER_ISSUE_PAGE, page: () => CustomerIssuePage()),
    GetPage(name: PENDING_CUSTOMER_COMPLETE_PAGE, page: () => PendingCustomerCompletePage()),
    GetPage(name: COMPLETE_CUSTOMER_PAGE, page: () => CompleteCustomerPage()),
    GetPage(name: COMPLETE_CUSTOMER_DETAIL_PAGE, page: () => CompleteCustomerDetailPage()),
    GetPage(name: NEW_ORDER_CUSTOMER_PAGE, page: () => NewOrderCustomerPage()),
    GetPage(name: MY_LOCATION_PAGE, page: () => MyLocationPage()),
  ];
}