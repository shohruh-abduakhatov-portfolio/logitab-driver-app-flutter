import 'dart:async';
import 'package:driver_app_flutter/models/event.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io' show HttpHeaders;
import 'package:http_parser/http_parser.dart';

// const baseUrl = "https://api.logitab.ml/api/v1/";
const baseUrl = "http://192.168.1.105:8001/api/v1/mob";

class API {
  static var token;

  static Future get(url, {Uri uri}) async {
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString("auth_token");
    var deviceId = instance.getString("uid");

    var response = await http.get(url == null ? uri : url, headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      HttpHeaders.contentTypeHeader: 'application/json',
      "X-Device-Id": deviceId,
    });
    return response;
  }

  static Future send(url, func, {data = const {}, Uri uri}) async {
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString("auth_token");
    var deviceId = instance.getString("uid");

    var response = await func(url == null ? uri : url,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
          "X-Device-Id": deviceId,
        },
        body: jsonEncode(data));
    return response;
  }

  static Future post(url, {data = const {}, Uri uri}) async {
    return await send(url, http.post, data: data, uri: uri);
  }

  static Future put(url, {data = const {}, Uri uri}) async {
    return await send(url, http.put, data: data, uri: uri);
  }

  static Future ping() async {
    return await get(baseUrl + "/ping-mobile");
  }

  static Future login(String username, password) async {
    var url = baseUrl + "/user/login";
    return await post(url, data: {"username": username, "password": password});
  }

  static Future changePassword(String newPass, olfPass) async {
    var url = baseUrl + "/user/password";
    return await put(url,
        data: {'new_password': newPass, 'old_password': olfPass});
  }

  static Future forgotPassword(String email) async {
    var url = baseUrl + "/user/password";
    return await post(url, data: {'email': email});
  }

  static Future isAuthorized() {
    var url = baseUrl + "/user/is_authorized";
    return get(url);
  }

  static Future vehiclesList() async {
    var url = baseUrl + "/vehicle";
    return await post(url);
  }

  static Future confirmVehicle() async {
    var shared = await SharedPreferences.getInstance();
    var driverId = shared.getInt("driverId");
    var vehicleId = shared.getInt("vehicle_id");
    var url = baseUrl + "/vehicle/$vehicleId/driver/$driverId";
    return await put(url);
  }

  static Future editRequestsList() async {
    var shared = await SharedPreferences.getInstance();
    var driverId = shared.getInt("driverId");
    var url = baseUrl + "/log_edit_request";
    return await post(url, data: {'driver_id': driverId});
  }

  static Future editRequestDetail(int logId) async {
    var url = baseUrl + "/log_edit_request/$logId";
    return await post(url);
  }

  static Future acceptEditRequest(int logId) async {
    var url = baseUrl + "/log_edit_request/$logId/accept";
    return await post(url);
  }

  static Future rejectEditRequest(int logId) async {
    var url = baseUrl + "/log_edit_request/$logId/reject";
    return await post(url);
  }

  static Future fetchLogByDate(DateTime startDate, endDate) async {
    var formatter = new DateFormat('yyyy-MM-dd');
    var uri = new Uri.https(baseUrl, '/log', {
      "startDate": formatter.format(startDate),
      "endDate": formatter.format(endDate)
    });
    return await post(null, uri: uri);
  }

  static Future updateEvent(int event_id, LogEvent event) async {
    var url = baseUrl + "/update/$event_id/accept";
    return await post(url, data: event.toMap());
  }

  static Future insertEvent(int event_id, LogEvent event) async {
    var url = baseUrl + "/insert/$event_id/accept";
    return await post(url, data: event.toMap());
  }

  static Future saveSignature(data, filename) async {
    var uri = new Uri.https(baseUrl, '/log/sign', {});
    var request = new http.MultipartRequest("POST", uri);
    // request.fields['user_id'] = '2';
    request.files.add(http.MultipartFile.fromBytes(
      'picture',
      data,
      filename: filename,
      contentType: new MediaType('image', 'png'),
    ));
    return request.send();
  }
}
