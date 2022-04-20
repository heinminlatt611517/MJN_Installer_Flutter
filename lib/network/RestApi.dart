import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:mjn_installer_app/models/allDropDownListVO.dart';
import 'package:mjn_installer_app/models/b2bAndb2cUsagesVO.dart';
import 'package:mjn_installer_app/models/installationVO.dart';
import 'package:mjn_installer_app/models/installationDetailVO.dart';
import 'package:mjn_installer_app/models/networkResultVO.dart';
import 'package:mjn_installer_app/models/serviceTicketDetailVO.dart';
import 'package:mjn_installer_app/models/serviceTicketVO.dart';
import 'package:mjn_installer_app/models/serviceTicket_and_installation_countsVO.dart';
import 'package:mjn_installer_app/models/smsResponseVO.dart';
import 'package:mjn_installer_app/models/supportLoginVO.dart';
import 'package:mjn_installer_app/utils/app_constants.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class RestApi {
  static final String securityKey = 'moJoENEt2021sECuriTYkEy';
  static var client = http.Client();
  static GetStorage writeData = GetStorage();

  static Future<SupportLoginVo> fetchSupportLogin(
      Map<String, String> params) async {
    debugPrint(params.toString());
    var response = await client.post(
      Uri.parse(SUPPORT_LOGIN_URL),
      body: json.encode(params),
      headers: {
        'content-type': 'application/json',
        "security_key": securityKey
      },
    );

    if (response.statusCode == 200) {
      debugPrint(response.body);
      return SupportLoginVo.fromJson(jsonDecode(response.body));
    } else {
      print(response.statusCode);
      throw Exception('Failed to login');
    }
  }

  static Future<void> postInstallerLatitudeAndLongitude(
      Map<String, String> params,String token) async {

    debugPrint("Lat And Long::${params.toString()}");
    var response = await client.post(
      Uri.parse(POST_INSTALLER_LAT_LONG_URL),
      body: json.encode(params),
      headers: {
        'content-type': 'application/json',
        "token": token
      },
    );

    if (response.statusCode == 200) {
      debugPrint(response.body);

    } else {
      print(response.statusCode);
      throw Exception('Failed to post data');
    }
  }

  static Future<SmsResponseVo> firstTimeSendSMSToServer(
      Map<String, String> params,String token) async {
    debugPrint("Send SmS${params.toString()}");
    debugPrint(params.toString());
    var response = await client.post(
      Uri.parse(SEND_SMS_BRIX_URL),
      body: json.encode(params),
      headers: {
        'content-type': 'application/json',
        "token": token
      },
    );

    if (response.statusCode == 200) {
      debugPrint(response.body);
      return smsResponseVoFromJson(response.body);
    } else {
      print(response.statusCode);
      throw Exception('Failed to post data');
    }
  }



  static void sendLatAndLongHitToServer(
      Map<String, String> params, String token) async {
    debugPrint("Lat And Long::${params.toString()}");
    var response = await client.post(
      Uri.parse(LATITUDE_LONGITUDE_URL),
      body: json.encode(params),
      headers: {'content-type': 'application/json', "token": token},
    );

    if (response.statusCode == 200) {
      debugPrint(response.body);
      // If the server did return a 200 OK response,
      // then parse the JSON.
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print(response.statusCode);
      throw Exception('Failed to send data');
    }
  }

  static Future<ServiceTicketVo> fetchServiceTicketPendingLists(
      String token, String uid, String status) async {
    var response = await client.get(
      Uri.parse(SERVICE_TICKET_LIST_URL +
          UID_PARAM +
          uid +
          STATUS_PARAM +
          status +
          APP_VERSION +
          app_version),
      headers: {'content-type': 'application/json', 'token': token},
    );
    if (response.statusCode == 200) {
      debugPrint(response.body);
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return serviceTicketVoFromJson(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print(response.statusCode);
      throw Exception('Failed to get service ticket lists');
    }
  }

  static Future<InstallationVo> fetchInstallationPendingLists(
      String token, String uid, String status) async {
    var response = await client.get(
      Uri.parse(INSTALLATION_LIST_URL +
          UID_PARAM +
          uid +
          STATUS_PARAM +
          status +
          APP_VERSION +
          app_version),
      headers: {'content-type': 'application/json', 'token': token},
    );
    if (response.statusCode == 200) {
      debugPrint(response.body);
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return installationVoFromJson(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print(response.statusCode);
      throw Exception('Failed to get pending  lists');
    }
  }

  static Future<InstallationDetailVo> getInstallationDetail(
      String token, String uid, String profileId) async {
    var response = await client.get(
      Uri.parse(GET_INSTALLATION_DETAIL_URL +
          UID_PARAM +
          uid +
          PROFILE_ID_PARAM +
          profileId +
          APP_VERSION +
          app_version),
      headers: {'content-type': 'application/json', 'token': token},
    );
    if (response.statusCode == 200) {
      debugPrint(response.body);
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return installationDetailVoFromJson(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print(response.statusCode);
      throw Exception('Failed to get installation detail');
    }
  }

  static Future<ServiceTicketDetailVo> getServiceTicketDetail(
      String token, String uid, String ticketID) async {
    var response = await client.get(
      Uri.parse(GET_SERVICE_TICKET_DETAIL_URL +
          UID_PARAM +
          uid +
          TICKET_ID_PARAM +
          ticketID +
          APP_VERSION +
          app_version),
      headers: {'content-type': 'application/json', 'token': token},
    );
    if (response.statusCode == 200) {
      debugPrint(response.body);
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return serviceTicketDetailVoFromJson(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print(response.statusCode);
      throw Exception('Failed to get service ticket detail');
    }
  }

  static Future<AllDropDownListVo> fetchAllDropDownLists() async {
    var response = await client.get(
      Uri.parse(ALL_DDL_DATA),
      headers: {
        'content-type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      debugPrint(response.body);
      writeData.write(ALL_DROP_DOWN_LISTS, json.encode(response.body));
      return allDropDownListVoFromJson(response.body);
    } else {
      print(response.statusCode);
      throw Exception('Failed to get all drop down lists');
    }
  }

  static Future<NetworkResultVO?> postInstallationData(
      String token,
      Map<dynamic, dynamic> params
      ) async {
    debugPrint("Post Installation Data::${params.toString()}");
    var response = await client.post(
      Uri.parse(POST_INSTALLATION_DATA_URL),
      body: json.encode(params),
      headers: {'content-type': 'application/json','token': token},
    );

    if (response.statusCode == 200) {
      debugPrint(response.body);
      return networkResultVoFromJson(response.body);
    } else {
      print(response.statusCode);
      return null;
     // throw Exception('Failed to post installation data');
    }
    // var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // var length = await imageFile.length();
    //
    // var uri = Uri.parse(POST_INSTALLATION_DATA_URL);
    //
    // Map<String, String> headers = {
    //   "content-type": "application/json",
    //   "token": "Bearer " + token
    // };
    // var request = new http.MultipartRequest("POST", uri);
    // request.fields['uid'] = '2948';
    // request.fields['profile_id'] = 'O61d55b6ac2f9f6.78990813';
    // request.fields['app_version'] = app_version;
    // request.fields['sr_no'] = '';
    // request.fields['spliter_no'] = '';
    // request.fields['fiber_usage'] = '';
    // request.fields['status'] = '';
    // request.fields['alert_time'] = DateTime.now().toString();
    //
    // var multipartFile = new http.MultipartFile('onuImageFile', stream, length,
    //     filename: basename(imageFile.path));
    // //contentType: new MediaType('image', 'png'));
    //
    // //request.files.add(multipartFile);
    // request.headers.addAll(headers);
    // var response = await request.send();
    // print(response.statusCode);
    // response.stream.transform(utf8.decoder).listen((value) {
    //   print(value);
    // });
    //
    // return NetworkResultVO();
  }

  static Future<NetworkResultVO> postServiceTicketData(
      Map<dynamic, dynamic> params, String token) async {
    debugPrint("Post ServiceTicket Data${params.toString()}");
    var response = await client.post(
      Uri.parse(POST_SERVICE_TICKET_DATA_URL),
      body: json.encode(params),
      headers: {'content-type': 'application/json', 'token': token},
    );

    if (response.statusCode == 200) {
      debugPrint(response.body);
      return networkResultVoFromJson(response.body);
    } else {
      print(response.statusCode);
      throw Exception('Failed to post service ticket data');
    }
  }

  static Future<ServiceTicketAdnInstallationCountsVO>
      fetchAllCountsForInstallationAndService(String uid, String token) async {
    var response = await client.get(
      Uri.parse(
          GET_ALL_COUNT_URL + UID_PARAM + uid + APP_VERSION + app_version),
      headers: {'content-type': 'application/json', 'token': token},
    );

    if (response.statusCode == 200) {
      debugPrint(response.body);
      json.decode(response.body).forEach((key, value){
        print('key is $key');
        print('value is $value ');
      });

      return serviceTicketAdnInstallationCountsFromJson(response.body);
    } else {
      print(response.statusCode);
      throw Exception('Failed to get all counts');
    }
  }

  static Future<ServiceTicketVo> fetchServiceTicketListsByStatus(
      String token, String uid, String status, String paramAndStatus) async {
    debugPrint(
        "TicketListByStatus${SERVICE_TICKET_LIST_URL + UID_PARAM + uid + APP_VERSION + app_version + STATUS_PARAM + status + paramAndStatus}");
    var response = await client.get(
      Uri.parse(SERVICE_TICKET_LIST_URL +
          UID_PARAM +
          uid +
          APP_VERSION +
          app_version +
          STATUS_PARAM +
          status +
          paramAndStatus),
      headers: {'content-type': 'application/json', 'token': token},
    );
    if (response.statusCode == 200) {
      debugPrint(response.body);
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return serviceTicketVoFromJson(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print(response.statusCode);
      throw Exception('Failed to get service ticket lists');
    }
  }

  static Future<InstallationVo> fetchInstallationListsByStatus(
      String token, String uid, String status, String paramAndStatus) async {
    debugPrint(
        "InstallationListByStatus${SERVICE_TICKET_LIST_URL + UID_PARAM + uid + APP_VERSION + app_version + STATUS_PARAM + status + paramAndStatus}");
    var response = await client.get(
      Uri.parse(INSTALLATION_LIST_URL +
          UID_PARAM +
          uid +
          APP_VERSION +
          app_version +
          STATUS_PARAM +
          status +
          paramAndStatus),
      headers: {'content-type': 'application/json', 'token': token},
    );
    if (response.statusCode == 200) {
      debugPrint(response.body);
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return installationVoFromJson(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print(response.statusCode);
      throw Exception('Failed to get pending  lists');
    }
  }

  static Future<NetworkResultVO> serviceTicketOrderAcceptAndLater(
      Map<String, String> params, String token) async {
    debugPrint(params.toString());
    var response = await client.post(
      Uri.parse(SERVICE_TICKET_ORDER_ACCEPT_URL),
      body: json.encode(params),
      headers: {'content-type': 'application/json', 'token': token},
    );

    if (response.statusCode == 200) {
      debugPrint(response.body);
      return networkResultVoFromJson(response.body);
    } else {
      print(response.statusCode);
      throw Exception('Service ticket failed to accept order later');
    }
  }

  static Future<NetworkResultVO> installationOrderAcceptAndLater(
      Map<String, String> params, String token) async {
    debugPrint(params.toString());
    var response = await client.post(
      Uri.parse(INSTALLATION_ORDER_ACCEPT_URL),
      body: json.encode(params),
      headers: {'content-type': 'application/json', 'token': token},
    );

    if (response.statusCode == 200) {
      debugPrint(response.body);
      return networkResultVoFromJson(response.body);
    } else {
      print(response.statusCode);
      throw Exception('Installation failed to accept  order later');
    }
  }

  static Future<B2BAndB2CUsagesVo> fetchInstallationUsages(String token,String uid,String type) async {
    var response = await client.get(
      Uri.parse(
          GET_INSTALLATION_USAGES_URL + TYPE_PARAM + type + APP_VERSION + app_version + UID_PARAM + uid),
      headers: {'content-type': 'application/json', 'token': token},
    );

    if (response.statusCode == 200) {
      debugPrint(response.body);
      json.decode(response.body).forEach((key, value) {
        print('key is $key');
        print('value is $value ');
      });

      return B2BAndB2CUsagesVo.fromJson(json.decode(response.body));

    } else {
      print(response.statusCode);
      throw Exception('Failed to get all installation usages');
    }
  }
}
