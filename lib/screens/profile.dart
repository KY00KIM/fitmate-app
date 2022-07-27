import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitmate/screens/login.dart';
import 'package:fitmate/screens/profileEdit.dart';
import 'package:fitmate/utils/data.dart';
import 'package:flutter/material.dart';

import 'package:fitmate/screens/writing.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'chatList.dart';
import 'home.dart';
import 'matching.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  String getSchedule() {
    if(UserData["data"]["user_schedule_time"] == 0) return "오전";
    else if(UserData["data"]["user_schedule_time"] == 1) return "오후";
    else return "저녁";
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xFF22232A),
      appBar: AppBar(
        elevation: 0.0,
        shape: Border(
          bottom: BorderSide(
            color: Color(0xFF3D3D3D),
            width: 1,
          ),
        ),
        backgroundColor: Color(0xFF22232A),
        title: Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: Text(
            "프로필",
            style: TextStyle(
              color: Color(0xFFffffff),
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          PopupMenuButton(
            iconSize: 30,
            color: Color(0xFF22232A),
            shape: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF757575),
                width: 1,
              ),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            elevation: 40,
            onSelected: (value) async {
              if (value == '/edit') Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileEditPage()));
              else if (value == '/logout'){ 
                print('로그아웃');
              }
            },
            itemBuilder: (BuildContext bc) {
              return [
                PopupMenuItem(
                  child: Text(
                    '수정하기',
                    style: TextStyle(
                      color: Color(0xFFffffff),
                    ),
                  ),
                  value: '/edit',
                ),
                PopupMenuItem(
                  child: Text(
                    '로그아웃',
                    style: TextStyle(
                      color: Color(0xFFffffff),
                    ),
                  ),
                  value: '/logout',
                ),
              ];
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF22232A),
        child: Container(
          width: size.width,
          //height: 60.0,
          height: size.height * 0.08,
          child: Row(
            children: [
              SizedBox(
                //width: 15,
                width: size.width * 0.04,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  splashFactory: NoSplash.splashFactory,
                ),
                onPressed: () {
                  //Route route = MaterialPageRoute(builder: (context) => HomePage());
                  //Navigator.pushReplacement(context, route);
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => HomePage(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  );
                  /*
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => HomePage(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        return child;
                      },
                    ),
                  );

                   */
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.home_filled,
                      color: Color(0xFF757575),
                      //size: 30.0,
                      size: size.width * 0.0763,
                    ),
                    Text(
                      '홈',
                      style: TextStyle(
                        color: Color(0xFF757575),
                        //fontSize: 10.0,
                        fontSize: size.width * 0.0253,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                //width: 10.0,
                width: size.width * 0.025,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  splashFactory: NoSplash.splashFactory,
                ),
                onPressed: () {
                  //Route route = MaterialPageRoute(builder: (context) => ChatListPage());
                  //Navigator.pushReplacement(context, route);
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => ChatListPage(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  );
                  /*
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => ChatListPage(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        return child;
                      },
                    ),
                  );

                   */
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.chat_bubble_outline,
                      color: Color(0xFF757575),
                      //size: 30.0,
                      size: size.width * 0.0763,
                    ),
                    Text(
                      '내 대화',
                      style: TextStyle(
                        color: Color(0xFF757575),
                        //fontSize: 10.0,
                        fontSize: size.width * 0.0253,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                //width: 80.0,
                width: size.width * 0.24,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  splashFactory: NoSplash.splashFactory,
                ),
                onPressed: () {
                  //Route route = MaterialPageRoute(builder: (context) => MatchingPage());
                  //Navigator.pushReplacement(context, route);
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => MatchingPage(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  );
                  /*
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => MatchingPage(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        return child;
                      },
                    ),
                  );

                   */
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.fitness_center,
                      color: Color(0xFF757575),
                      //size: 30.0,
                      size: size.width * 0.0763,
                    ),
                    Text(
                      '매칭',
                      style: TextStyle(
                        color: Color(0xFF757575),
                        //fontSize: 10.0,
                        fontSize: size.width * 0.0253,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: size.width * 0.025,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  splashFactory: NoSplash.splashFactory,
                ),
                onPressed: () {
                  //Route route = MaterialPageRoute(builder: (context) => ProfilePage());
                  //Navigator.pushReplacement(context, route);
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.person,
                      color: Color(0xFFffffff),
                      size: size.width * 0.0763,
                    ),
                    Text(
                      '프로필',
                      style: TextStyle(
                        color: Color(0xFFffffff),
                        //fontSize: 10.0,
                        fontSize: size.width * 0.0253,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(top: 30.0),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Color(0xFF22232A),
        ),
        child: FloatingActionButton(
            child: Icon(
              Icons.add,
              size: 40,
            ),
            backgroundColor: Color(0xFF303037),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => WritingPage()));
            }
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: Column(
            children: [
              Container(
                width: size.width - 34,
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: Image.network(
                        'https://lh3.googleusercontent.com/a-/AFdZucrZLMIGoom5ZRl_l8ZxegVkQLyhlvLJMu2Ott2R0w=s96-c',
                        width: 70.0,
                        height: 70.0,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${UserData["data"]["user_nickname"]}(${UserData["data"]["user_gender"] == false ? '남' : '여'})',
                      style: TextStyle(
                        color: Color(0xFFffffff),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: size.width - 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '기본 루틴',
                      style: TextStyle(
                        color: Color(0xFFffffff),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        '${getSchedule()}',
                        style: TextStyle(
                          color: Color(0xFF2975CF),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: size.width - 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0xFF22232A),
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(
                          width: 1,
                          color: Color(0xFF878E97),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '월',
                        style: TextStyle(
                            color: UserData["data"]["user_weekday"]["mon"] == true ? Color(0xFFffffff) : Color(0xFF878E97),
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0xFF22232A),
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(
                          width: 1,
                          color: Color(0xFF878E97),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '화',
                        style: TextStyle(
                            color: UserData["data"]["user_weekday"]["tue"] == true ? Color(0xFFffffff) : Color(0xFF878E97),
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0xFF22232A),
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(
                          width: 1,
                          color: Color(0xFF878E97),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '수',
                        style: TextStyle(
                            color: UserData["data"]["user_weekday"]["wed"] == true ? Color(0xFFffffff) : Color(0xFF878E97),
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: UserData["data"]["user_weekday"]["thu"] == true ? BoxDecoration(
                        color: Color(0xFF22232A),
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(
                          width: 1,
                          color: Color(0xFF878E97),
                        ),
                      ) : BoxDecoration(
                        color: Color(0xFF22232A),
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(
                          width: 1,
                          color: Color(0xFF878E97),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '목',
                        style: TextStyle(
                            color: UserData["data"]["user_weekday"]["thu"] == true ? Color(0xFFffffff) : Color(0xFF878E97),
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: UserData["data"]["user_weekday"]["fri"] == true ? BoxDecoration(
                        color: Color(0xFF22232A),
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(
                          width: 1,
                          color: Color(0xFF878E97),
                        ),
                      ) : BoxDecoration(
                        color: Color(0xFF22232A),
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(
                          width: 1,
                          color: Color(0xFF878E97),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '금',
                        style: TextStyle(
                            color: UserData["data"]["user_weekday"]["fri"] == true ? Color(0xFFffffff) : Color(0xFF878E97),
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: UserData["data"]["user_weekday"]["sat"] == true ? BoxDecoration(
                        color: Color(0xFF22232A),
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(
                          width: 1,
                          color: Color(0xFF878E97),
                        ),
                      ) : BoxDecoration(
                        color: Color(0xFF22232A),
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(
                          width: 1,
                          color: Color(0xFF878E97),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '토',
                        style: TextStyle(
                            color: UserData["data"]["user_weekday"]["sat"] == true ? Color(0xFFffffff) : Color(0xFF878E97),
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: UserData["data"]["user_weekday"]["sun"] == true ? BoxDecoration(
                        color: Color(0xFF22232A),
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(
                          width: 1,
                          color: Color(0xFF878E97),
                        ),
                      ) : BoxDecoration(
                        color: Color(0xFF22232A),
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(
                          width: 1,
                          color: Color(0xFF878E97),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '일',
                        style: TextStyle(
                            color: UserData["data"]["user_weekday"]["sun"] == true ? Color(0xFFffffff) : Color(0xFF878E97),
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: size.width - 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '기본 정보',
                      style: TextStyle(
                        color: Color(0xFFffffff),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: size.width - 40,
                height: 112,
                decoration: BoxDecoration(
                  color: Color(0xFF22232A),
                  border: Border.all(width: 1, color: Color(0xFF757575)),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(22, 15, 22, 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_pin,
                                  color: Color(0xFF2975CF),
                                  size: 17,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  '내 동네',
                                  style: TextStyle(
                                    color: Color(0xFFffffff),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '${UserData["data"]["user_address"]}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFffffff),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.fitness_center,
                                  color: Color(0xFF2975CF),
                                  size: 17,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  '내 피트니스장',
                                  style: TextStyle(
                                    color: Color(0xFFffffff),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '${UserData["data"]["fitness_center_id"]}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFffffff),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.groups,
                                  color: Color(0xFF2975CF),
                                  size: 17,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  '매칭 수',
                                  style: TextStyle(
                                    color: Color(0xFFffffff),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '3회',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFffffff),
                            ),
                          ),
                        ],
                      ),
                      /*
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.thumb_up_alt,
                                  color: Color(0xFF2975CF),
                                  size: 17,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  '매칭 후기',
                                  style: TextStyle(
                                    color: Color(0xFFffffff),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '좋아요',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFffffff),
                            ),
                          ),
                        ],
                      ),
                      */
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                width: size.width - 40,
                height: 1,
                color: Color(0xFF757575),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: size.width - 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '메이트 리뷰',
                      style: TextStyle(
                        color: Color(0xFFffffff),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: size.width - 40,
                child: Column(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: Image.network(
                            'http://newsimg.hankookilbo.com/2018/03/07/201803070494276763_1.jpg',
                            width: 35.0,
                            height: 35.0,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          '우천류',
                          style: TextStyle(
                            color: Color(0xFFffffff),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 45),
                      child: Container(
                        width: size.width - 85,
                        child: Flexible(
                          child: RichText(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 100,
                            strutStyle: StrutStyle(fontSize: 16),
                            text: TextSpan(
                              text: '어깨 제대로 부수실 분앙아아아ㅇ러냐릔두ㅑ루디루댜sdfsfsfsfd아아',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
