//import 'dart:_http';
import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fitmate/screens/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fitmate/firebase_service/firebase_auth_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitmate/screens/home.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:fitmate/utils/data.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xff22232A),
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Opacity(
                  opacity: 0.4,
                  child: Image.asset(
                    "assets/images/sign_up_background.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset(
                        'assets/images/fitmate_logo.png',
                        width: 140,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        '???????????? ????????????\nMate??? ???????????????',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 23.0),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                IdToken = await FirebaseAuthMethods(
                                        FirebaseAuth.instance)
                                    .signInWithGoogle(context);
                                IdToken = (await FirebaseAuth
                                        .instance.currentUser
                                        ?.getIdTokenResult(true))!
                                    .token
                                    .toString();

                                if (IdToken == 'error') {
                                  FlutterToastTop("?????? ?????? ????????? ?????????????????????");
                                } else {
                                  String? deviceToken = await FirebaseMessaging
                                      .instance
                                      .getToken();
                                  var iosToken = await FirebaseMessaging
                                      .instance
                                      .getAPNSToken();
                                  print(
                                      'THIS IS ios APNS TOKEN :  ${iosToken}');

                                  print('deviceToken : ${deviceToken}');

                                  // ignore: avoid_print
                                  print("device token : ${deviceToken}");
                                  //????????? ?????? ???????????? ????????? ?????? ????????????
                                  http.Response response = await http.get(
                                      Uri.parse("${baseUrl}users/login"),
                                      headers: {
                                        'Authorization': 'bearer $IdToken',
                                        // ignore: unnecessary_brace_in_string_interps
                                        'device': '${deviceToken}'
                                      });
                                  var resBody = jsonDecode(
                                      utf8.decode(response.bodyBytes));
                                  print(resBody);

                                  if (response.statusCode == 200) {
                                    //????????? ????????? ????????? ?????? ???????????????
                                    UserId = resBody['data']['user_id'];

                                    bool userdata = await UpdateUserData();

                                    if (userdata == true) {
                                      Navigator.pushReplacement(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation,
                                                  secondaryAnimation) =>
                                              HomePage(
                                            reload: true,
                                          ),
                                          transitionDuration: Duration.zero,
                                          reverseTransitionDuration:
                                              Duration.zero,
                                        ),
                                      );
                                    } else {
                                      print("else ??? ??????");
                                      FlutterToastTop("?????? ?????? ????????? ?????????????????????");
                                    }
                                  } else if (resBody['message'] == 404) {
                                    // ????????? ????????? ?????? ?????? ???????????????
                                    Navigator.pushReplacement(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            SignupPage(),
                                        transitionDuration: Duration.zero,
                                        reverseTransitionDuration:
                                            Duration.zero,
                                      ),
                                    );
                                  } else {
                                    //????????? ?????? ?????????
                                    log(resBody);
                                    FlutterToastTop("?????? ?????? ????????? ?????????????????????");
                                  }
                                }
                              },
                              child: Row(
                                //spaceEvenly: ???????????? ???????????? ???????????? ??????
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    'assets/icon/google-logo.png',
                                    width: 20.0,
                                    height: 20.0,
                                  ),
                                  Text(
                                    'Google??? ?????????',
                                    style: TextStyle(
                                        color: Color.fromRGBO(0, 0, 0, 0.54),
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox()
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                side: BorderSide(
                                    width: 0.0, color: Color(0xff878E97)),
                                primary: Color(0xFFffffff),
                                //shadowColor: Colors.black, ????????? ???????????? ??????

                                minimumSize: Size.fromHeight(40), // ????????? 50?????? ??????
                                elevation: 1.0,
                                shape: RoundedRectangleBorder(
                                    // shape : ????????? ????????? ????????? ?????? ??????
                                    borderRadius: BorderRadius.circular(20.0)),
                              ),
                            ),
                            SizedBox(height: 5,),
                            ElevatedButton(
                              onPressed: () async {
                                await FirebaseAuthMethods(FirebaseAuth.instance).signInWithApple().then((val) => {});
                                IdToken = (await FirebaseAuth
                                    .instance.currentUser
                                    ?.getIdTokenResult(true))!
                                    .token
                                    .toString();

                                if (IdToken == 'error') {
                                  FlutterToastTop("?????? ?????? ????????? ?????????????????????");
                                } else {
                                  String? deviceToken = await FirebaseMessaging
                                      .instance
                                      .getToken();
                                  var iosToken = await FirebaseMessaging
                                      .instance
                                      .getAPNSToken();
                                  print(
                                      'THIS IS ios APNS TOKEN :  ${iosToken}');

                                  print('deviceToken : ${deviceToken}');

                                  // ignore: avoid_print
                                  print("device token : ${deviceToken}");
                                  //????????? ?????? ???????????? ????????? ?????? ????????????
                                  http.Response response = await http.get(
                                      Uri.parse("${baseUrl}users/login"),
                                      headers: {
                                        'Authorization': 'bearer $IdToken',
                                        // ignore: unnecessary_brace_in_string_interps
                                        'device': '${deviceToken}'
                                      });
                                  var resBody = jsonDecode(
                                      utf8.decode(response.bodyBytes));
                                  print(resBody);

                                  if (response.statusCode == 200) {
                                    //????????? ????????? ????????? ?????? ???????????????
                                    UserId = resBody['data']['user_id'];

                                    bool userdata = await UpdateUserData();

                                    if (userdata == true) {
                                      Navigator.pushReplacement(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                              HomePage(
                                                reload: true,
                                              ),
                                          transitionDuration: Duration.zero,
                                          reverseTransitionDuration:
                                          Duration.zero,
                                        ),
                                      );
                                    } else {
                                      print("else ??? ??????");
                                      FlutterToastTop("?????? ?????? ????????? ?????????????????????");
                                    }
                                  } else if (resBody['message'] == 404) {
                                    // ????????? ????????? ?????? ?????? ???????????????
                                    Navigator.pushReplacement(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                            SignupPage(),
                                        transitionDuration: Duration.zero,
                                        reverseTransitionDuration:
                                        Duration.zero,
                                      ),
                                    );
                                  } else {
                                    //????????? ?????? ?????????
                                    log(resBody);
                                    FlutterToastTop("?????? ?????? ????????? ?????????????????????");
                                  }
                                }
                              },
                              child: Row(
                                //spaceEvenly: ???????????? ???????????? ???????????? ??????
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    'assets/icon/apple-logo.png',
                                    width: 25.0,
                                    height: 25.0,
                                  ),
                                  Text(
                                    'Apple??? ?????????',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox()
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                side: BorderSide(
                                    width: 0.0, color: Color(0xff878E97)),
                                primary: Color(0xFFffffff),
                                //shadowColor: Colors.black, ????????? ???????????? ??????

                                minimumSize: Size.fromHeight(40), // ????????? 50?????? ??????
                                elevation: 1.0,
                                shape: RoundedRectangleBorder(
                                  // shape : ????????? ????????? ????????? ?????? ??????
                                    borderRadius: BorderRadius.circular(20.0)),
                              ),
                            ),
                            /*
                            SizedBox(
                              width: 300,
                              child: TextButton.icon(
                                onPressed: () async {
                                  IdToken = await FirebaseAuthMethods(FirebaseAuth.instance).signInWithGoogle(context);
                                  IdToken = (await FirebaseAuth.instance.currentUser?.getIdTokenResult(true))!.token.toString();

                                  if(IdToken == 'error') {
                                    FlutterToastTop("?????? ?????? ????????? ?????????????????????");
                                  }
                                  else {
                                    String? deviceToken = await FirebaseMessaging.instance.getToken();
                                    //????????? ?????? ???????????? ????????? ?????? ????????????
                                    http.Response response = await http.get(Uri.parse("${baseUrl}users/login"), headers: {
                                      'Authorization' : 'bearer $IdToken',
                                      'deviceToken' : '${deviceToken}'
                                    });
                                    var resBody = jsonDecode(utf8.decode(response.bodyBytes));

                                    if(response.statusCode == 200) {
                                      //????????? ????????? ????????? ?????? ???????????????
                                      UserId = resBody['data']['user_id'];

                                      bool userdata = await UpdateUserData();

                                      if(userdata == true) {
                                        Navigator.pushReplacement(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation, secondaryAnimation) => HomePage(reload: true,),
                                            transitionDuration: Duration.zero,
                                            reverseTransitionDuration: Duration.zero,
                                          ),
                                        );
                                      }
                                      else {
                                        print("else ??? ??????");
                                        FlutterToastTop("?????? ?????? ????????? ?????????????????????");
                                      }
                                    } else if(resBody['message'] == 404) {
                                      // ????????? ????????? ?????? ?????? ???????????????
                                      Navigator.pushReplacement(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation, secondaryAnimation) => SignupPage(),
                                          transitionDuration: Duration.zero,
                                          reverseTransitionDuration:
                                              Duration.zero,
                                        ),
                                      );
                                    } else {
                                      //????????? ?????? ?????????
                                      log(resBody);
                                      FlutterToastTop("?????? ?????? ????????? ?????????????????????");
                                    }
                                  }
                                },
                                /*
                                child: Row(
                                  //spaceEvenly: ???????????? ???????????? ???????????? ??????
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    SizedBox(width: 25,),
                                    Text(
                                      '????????? ????????????',
                                      style: TextStyle(color: Color(0xFF000000), fontSize: 18.0, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                */

                                icon: Container(
                                    width: 25,
                                    height: 25,
                                    // decoration: BoxDecoration(color: Colors.blue),
                                    child: Image.network(
                                        'http://pngimg.com/uploads/google/google_PNG19635.png',
                                        fit:BoxFit.cover
                                    )
                                ),
                                label: Text(
                                  '????????? ????????????',
                                  style: TextStyle(color: Color(0xFF000000), fontSize: 18.0, fontWeight: FontWeight.bold),
                                ),

                              ),
                            ),
                            TextButton(
                              onPressed: () async {

                              },
                              child: Text(
                                '?????? ?????????',
                                style: TextStyle(color: Colors.white, fontSize: 18.0),
                              ),
                            ),
                            */
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 35.0,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
