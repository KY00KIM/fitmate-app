import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';

//공통 변수

Map fitnessPart = {
  "62c670514b8212e4674dbe34": '등',
  '62c670404b8212e4674dbe33' : '어깨',
  '62c6706e4b8212e4674dbe37' : '이두',
  '62c6705e4b8212e4674dbe35' : '가슴',
  '62c6707f4b8212e4674dbe38' : '삼두',
  '62c670874b8212e4674dbe39' : '복근',
  '62c670664b8212e4674dbe36' : '하체',
  '62c670a04b8212e4674dbe3a' : '유산소'
};

Map fitnessPartConverse = {
  '등' : "62c670514b8212e4674dbe34",
  '어깨' : '62c670404b8212e4674dbe33',
  '이두' : '62c6706e4b8212e4674dbe37',
  '가슴' : '62c6705e4b8212e4674dbe35',
  '삼두' : '62c6707f4b8212e4674dbe38',
  '복근' : '62c670874b8212e4674dbe39',
  '하체' : '62c670664b8212e4674dbe36',
  '유산소' : '62c670a04b8212e4674dbe3a'
};

class LoginedUser {
  late String _id;
  late String User_name;
  late String user_address;
}

String UserCenterName = '';
late Map UserData = {
  "_id": "",
  "user_name": "",
  "user_address": "",
  "user_nickname": "",
  "user_email": "",
  "user_profile_img": "",
  "user_schedule_time": 0,
  "user_weekday": [],
  "user_introduce": "",
  "user_fitness_part": [
    ""
  ],
  "user_age": 0,
  "user_gender": true,
  "user_loc_bound": 3,
  "fitness_center_id": "",
  "user_longitude": 0,
  "user_latitude": 0,
  "location_id": "",
  "social": {
    "user_id": "",
    "user_name": "",
    "provider": "",
    "device_token": [
      ""
    ],
    "firebase_info": {}
  },
  "is_deleted": false,
  "createdAt": "",
  "updatedAt": ""
};


// ignore: non_constant_identifier_names
Future<bool> UpdateUserData() async {
  log(IdToken.toString());
  http.Response response = await http.get(Uri.parse("${baseUrl}users/${UserId.toString()}"), headers: {
    // ignore: unnecessary_string_interpolations
    "Authorization" : "bearer ${IdToken.toString()}",
    "Content-Type" : "application/json; charset=UTF-8",
    "userId" : "${UserId.toString()}"});
  if (response.statusCode == 200) {
    var resBody = jsonDecode(utf8.decode(response.bodyBytes));

    UserData = resBody["data"];
    print("fitness center id : ${UserData["fitness_center_id"].toString()}");
    http.Response responseFitness = await http.get(Uri.parse("${baseUrl}fitnesscenters/${UserData["fitness_center_id"].toString()}"), headers: {
      // ignore: unnecessary_string_interpolations
      "Authorization" : "bearer ${IdToken.toString()}",
      "fitnesscenterId" : "${UserData["fitness_center_id"]}"});
    log(UserData.toString());
    if(responseFitness.statusCode == 200) {
      var resBody2 = jsonDecode(utf8.decode(responseFitness.bodyBytes));

      UserCenterName = resBody2["data"]["center_name"];
    }
    return true;
  } else {
    print("유저 정보 가져오지 못함");
    return false;
  }
}

Future<Position> DeterminePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    await Geolocator.openLocationSettings();
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {

      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {

    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  return await Geolocator.getCurrentPosition();
}


late String IdToken;
late String UserId;

String baseUrl = "https://fitmate.co.kr/v1/";