import 'package:diving/Controllers/UserController.dart';
import 'package:diving/Models/PromoCode.dart';
import 'package:diving/Repository/UserRepository.dart';
import 'package:diving/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Controllers/CourseController.dart';
import '../../Controllers/PromoCodeController.dart';
import '../../Controllers/UserCourseController.dart';
import '../../Models/Course.dart';
import '../../Models/User.dart';
import '../../Models/UserCourse.dart';
import '../../Repository/CourseRepository.dart';
import '../../Repository/PromoCodeRepository.dart';
import '../../Repository/UserCourseRepository.dart';
import 'CoursesPage.dart';

class CourseInfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CourseInfoPageState();
  }

  final User user;
  final Course course;

  CourseInfoPage(this.user, this.course);
}

class _CourseInfoPageState extends State<CourseInfoPage> {
  static const engLanguage = "English";
  static const ukrLanguage = "Українська";

  final _promoCodeInputController = TextEditingController(text: "0");

  Widget inputInformationComponent(String text, String label,
      [String val = '']) {
    return Container(
      height: 50,
      width: 300,
      margin: EdgeInsetsDirectional.fromSTEB(50, 40, 50, 0),
      padding: EdgeInsetsDirectional.fromSTEB(20, 15, 10, 5),
      child: Text(
        "$label: $text $val",
        style: TextStyle(fontSize: 16),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(100)),
          color: Colors.redAccent,
          boxShadow: [
            BoxShadow(
              color: Colors.black54.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ]),
    );
  }

  String language(int id) {
    if (id == 0) {
      return ukrLanguage;
    } else
      return engLanguage;
  }

  List<Widget> userInformationBar1() => [
        inputInformationComponent(
            widget.course.courseName ?? "", "Course name"),
        inputInformationComponent(
            widget.course.description ?? "", "Description"),
      ];

  List<Widget> userInformationBar2() => [
        inputInformationComponent(
            widget.course.cost.toString(), "Course Cost", "dollars"),
        inputInformationComponent(widget.course.minHoursUnderWater.toString(),
            "Minimal hours under water"),
      ];

  UserCourse createNewUserCourse(int promoCode) {
    UserCourse userCourse = new UserCourse(
        0,
        widget.user.id,
        widget.course.id,
        true,
        0,
        promoCode,
        0
    );
    return userCourse;
  }

  var promoCodeController = PromoCodeController(PromoCodeRepository());
  var userCourseController = UserCourseController(UserCourseRepository());

  @override
  Widget build(BuildContext context) {
    var curLanguage = language(widget.user.languageId!);
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(0, 0, 0, 1.0),
            centerTitle: true,
            title: const Text('ProDiver Admin'),
            actions: [
              PopupMenuButton(
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                      onTap: () async{
                        await context.setLocale(Locale('uk'));
                      },
                      value: ukrLanguage,
                      child: Text(
                        ukrLanguage,
                        style: TextStyle(color: Colors.white),
                      )),
                  PopupMenuItem(
                    onTap: () async{
                      await context.setLocale(Locale('en'));
                    },
                    child:
                        Text(engLanguage, style: TextStyle(color: Colors.white)),
                    value: engLanguage,
                  )
                ],
                onSelected: (String newValue) {
                  setState(() {
                    curLanguage = newValue;
                  });
                },
                color: Colors.black,
                child: Icon(Icons.location_on),
              )
            ],
            leading: Builder(builder: (BuildContext context) {
              return IconButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return CoursesPage(widget.user);
                  }), (route) => false);
                },
                icon: const Icon(Icons.arrow_back),
              );
            }),
          ),
          body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.indigo,
                Colors.red,
              ],
            )),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsetsDirectional.fromSTEB(30, 55, 40, 0),
                  child: Text(plural(LocaleKeys.viewing_course_, 0, namedArgs: {"courseName": widget.course.courseName!}),
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 50),
                  ),
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 250,
                      width: 400,
                      child: Image.network(
                        widget.course.image!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: userInformationBar1(),
                      ),
                    ),
                    Container(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: userInformationBar2()),
                    ),
                  ],
                ),
                Container(
                  height: 40,
                  width: 180,
                  margin: EdgeInsetsDirectional.fromSTEB(100, 25, 100, 0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                    ),
                    onPressed: () async {
                      if (widget.user.hoursUnderWater!.toInt() <
                          widget.course.minHoursUnderWater!) {
                        return showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(LocaleKeys.sorry_but_your_hours_under_water_is_lower_than_requires.tr()),
                              );
                            });
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) => SimpleDialog(
                                  title: Text(LocaleKeys.do_you_want_to_buy_this_course.tr()),
                                  contentPadding: const EdgeInsets.all(20.0),
                                  children: [
                                    TextFormField(
                                        controller: _promoCodeInputController),
                                    TextButton(
                                        onPressed: () async {
                                          final promoCode = await promoCodeController.getPromoCodeDataByName(_promoCodeInputController.text);
                                          if (promoCode.id != null) {
                                            final record = createNewUserCourse(promoCode.id!);
                                            await userCourseController.postUserCourse(record);
                                          }
                                          else{
                                            final record = createNewUserCourse(0);
                                            await userCourseController.postUserCourse(record);
                                          }

                                          Navigator.of(context).pop();
                                        },
                                        child: Text(LocaleKeys.confirm.tr())),
                                  ],
                                ));
                      }
                    },
                    child: Text(
                      LocaleKeys.buy_this_course.tr(),
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
