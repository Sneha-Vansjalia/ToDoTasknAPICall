import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import 'user_model.dart';

String API_BASE_URL = "https://reqres.in/api/users?page=2";

Map<String, String> requestHeaders = {
  HttpHeaders.contentTypeHeader: 'application/json',
  "Request-From": Platform.isAndroid ? "Android" : "Ios",
  HttpHeaders.acceptLanguageHeader: 'en',
};

class UserDataController extends GetxController {
  Rx<UserData> userData = UserData().obs;
  RxBool isError = false.obs;
  RxString errorMessage = "".obs;
  RxBool isloading = false.obs;

  Future<void> getUserData() async {
    isloading(true);
    try {
      String url = 'get_dashboard_data';
      var response = await http.get(
        Uri.parse(API_BASE_URL),
        headers: requestHeaders,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jasonData = json.decode(response.body);
    print(response.body);
       
          isError(false);
          errorMessage("");
          UserData userData1 = UserData.fromJson(jasonData);
      
          userData(userData1);
      
         
       
      } else {
        isError(true);
        errorMessage("Internal Server Error!");
      }
    } catch (e) {
      isError(true);
      print("UserData    --  ${e}   ");
      errorMessage(e.toString());
    } finally {
      isloading(false);
    }
  }
}
