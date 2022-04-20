// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:mjn_installer_app/network/RestApi.dart';
// import 'package:mjn_installer_app/utils/app_constants.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:location/location.dart';
//
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class MyLocation extends StatefulWidget {
//   String token;
//
//   MyLocation(this.token);
//
//   @override
//   _MyLocationState createState() => _MyLocationState();
// }
//
// class _MyLocationState extends State<MyLocation> {
//   LocationData? _currentPosition;
//
//   late GoogleMapController mapController;
//   late Marker marker;
//   Location location = Location();
//
//   late GoogleMapController _controller;
//   LatLng _initialcameraposition = LatLng(0.5937, 0.9629);
//   final readData = GetStorage();
//   var  saveTime ;
//   @override
//   void initState() {
//     super.initState();
//     saveTime = readData.read(SAVE_TIME);
//     getLoc();
//   }
//
//   void _onMapCreated(GoogleMapController _cntlr) {
//     _controller = _cntlr;
//     location.onLocationChanged.listen((l) {
//       _controller.animateCamera(
//         CameraUpdate.newCameraPosition(
//           CameraPosition(target: LatLng(l.latitude!, l.longitude!), zoom: 15),
//         ),
//       );
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     if (_currentPosition != null) {
//        if(saveTime < DateTime.now().minute){
//          Map<String, String> map = {
//            'lat': _currentPosition!.latitude.toString(),
//            'lon': _currentPosition!.longitude.toString()
//          };
//          RestApi.sendLatAndLongHitToServer(map, widget.token);
//
//          saveTime = DateTime.now().minute;
//
//        }
//
//     }
//     return Scaffold(
//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         child: SafeArea(
//           child: Container(
//             color: Colors.blueGrey.withOpacity(.8),
//             child: Container(
//               height: MediaQuery.of(context).size.height,
//               width: MediaQuery.of(context).size.width,
//               child: GoogleMap(
//                 initialCameraPosition: CameraPosition(
//                     target: _initialcameraposition, zoom: 15.0),
//                 mapType: MapType.normal,
//                 onMapCreated: _onMapCreated,
//                 myLocationEnabled: true,
//                 myLocationButtonEnabled: false,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   getLoc() async {
//     bool _serviceEnabled;
//     PermissionStatus _permissionGranted;
//
//     _serviceEnabled = await location.serviceEnabled();
//     if (!_serviceEnabled) {
//       _serviceEnabled = await location.requestService();
//       if (!_serviceEnabled) {
//         return;
//       }
//     }
//
//     _permissionGranted = await location.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted = await location.requestPermission();
//       if (_permissionGranted != PermissionStatus.granted) {
//         return;
//       }
//     }
//
//     _currentPosition = await location.getLocation();
//     _initialcameraposition =
//         LatLng(_currentPosition!.latitude!, _currentPosition!.longitude!);
//     location.onLocationChanged.listen((LocationData currentLocation) {
//       print("${currentLocation.longitude} : ${currentLocation.longitude}");
//       setState(() {
//         _currentPosition = currentLocation;
//         _initialcameraposition =
//             LatLng(_currentPosition!.latitude!, _currentPosition!.longitude!);
//       });
//     });
//   }
// }
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mjn_installer_app/components/button_component.dart';
import 'package:mjn_installer_app/controllers/home_controller.dart';
import 'package:mjn_installer_app/network/RestApi.dart';
import 'package:mjn_installer_app/res/colors.dart';
import 'package:mjn_installer_app/utils/app_constants.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:get/get.dart';

class MyLocationPage extends StatefulWidget {
  @override
  _MyLocationPageState createState() => _MyLocationPageState();
}

class _MyLocationPageState extends State<MyLocationPage> {
  var saveTime;
  StreamSubscription<LocationData>? locationSubscription;

  LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
  late GoogleMapController _controller;
  Location _location = Location();
  LocationData? _currentPosition;
  final readData = GetStorage();

  String firstTime = 'true';

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
    _location.onLocationChanged.listen((l) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude!, l.longitude!), zoom: 15),
        ),
      );
    });
  }

  @override
  void initState() {
    saveTime = readData.read(SAVE_TIME);
    super.initState();
    getLoc();
    firstTime = 'true';
  }

  @override
  void dispose() {
    super.dispose();
    if(locationSubscription != null){
      locationSubscription!.cancel();
    }

  }


  @override
  Widget build(BuildContext context) {

    postLatLongToServer();

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: _currentPosition != null
            ? Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 40.0, top: 30.0),
                    child: GoogleMap(
                      initialCameraPosition:
                          CameraPosition(target: _initialcameraposition),
                      mapType: MapType.normal,
                      onMapCreated: _onMapCreated,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                    ),
                  ),
                  Positioned.fill(
                      bottom: 1,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 40,
                          margin:
                              EdgeInsets.only(left: 20, right: 20, bottom: 20),
                          child: ButtonComponent(
                              padding: 8.0,
                              text: 'Arrive',
                              containerWidth: 160,
                              onPress: onPressArrive,
                              color: Color(
                                int.parse(MJNColors.buttonColor),
                              )),
                        ),
                      ))
                ],
              )
            : Container(),
      ),
    );
  }

  void postLatLongToServer() {

    if (_currentPosition != null) {
      debugPrint("SaveTime::${saveTime}");
      if (saveTime <= DateTime.now().minute) {
        debugPrint("PostLatLong");

        Map<String, String> map = {
          'uid': readData.read(UID),
          'customer_profile_id': HomeController.to.profileID,
          'lat': _currentPosition!.latitude.toString(),
          'long': _currentPosition!.longitude.toString(),
          'app_version': app_version,
          "isArrived":"0"
        };
        RestApi.postInstallerLatitudeAndLongitude(map, readData.read(TOKEN));
        // RestApi.postInstallerLatitudeAndLongitude(map, readData.read(TOKEN)).then((value) =>
        // firstTime == 'true' ? firstTimeSendSmSToServer() : null
        // );
        saveTime = DateTime.now().add(Duration(minutes: 3)).minute;
      }
    }
  }

  void firstTimeSendSmSToServer() {
    Map<String, String> map = {
      'uid': readData.read(UID),
      'phone' : HomeController.to.customerPhoneNo,
      'profile_id': HomeController.to.customerProfileID,
      'app_version': app_version,
    };
    RestApi.firstTimeSendSMSToServer(map, readData.read(TOKEN)).then((value) => {
      if(value.status == 'Success'){
        setState(() {
          firstTime = 'false';
        })
      }
    });
  }


  onPressArrive() {
    Map<String, String> map = {
      'uid': readData.read(UID),
      'customer_profile_id': HomeController.to.profileID,
      'lat': _currentPosition!.latitude.toString(),
      'long': _currentPosition!.longitude.toString(),
      'app_version': app_version,
      "isArrived":"1"
    };

    RestApi.postInstallerLatitudeAndLongitude(map, readData.read(TOKEN));

    Get.back();
  }

  getLoc() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await _location.getLocation();


    locationSubscription = _location.onLocationChanged.listen((LocationData currentLocation){
      print("${currentLocation.longitude} : ${currentLocation.longitude}");

      Future.delayed(Duration.zero, () {
        setState(() {
          _currentPosition = currentLocation;
          _initialcameraposition =
              LatLng(_currentPosition!.latitude!, _currentPosition!.longitude!);
        });
      });
    });

  }


}
