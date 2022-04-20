import 'dart:async';
import 'dart:io';
import 'package:baseflow_plugin_template/baseflow_plugin_template.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mjn_installer_app/utils/app_constants.dart';
import 'package:mjn_installer_app/utils/routers.dart';
import 'package:mjn_installer_app/views/home_page.dart';
import 'package:mjn_installer_app/views/new_login_page.dart';

/// Defines the main theme color.
final MaterialColor themeMaterialColor =
BaseflowPluginExample.createMaterialColor(
    const Color.fromRGBO(48, 49, 60, 1));
final readData = GetStorage();


Future  main() async{
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();

  if (defaultTargetPlatform == TargetPlatform.android) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  HttpOverrides.global = MyHttpOverrides();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

   return GetMaterialApp(
      debugShowCheckedModeBanner: false,
       getPages: Routers.route,
      home: readData.read(TOKEN) == null ? NewLoginPage() : HomePage());
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..maxConnectionsPerHost = 5;
  }
}



