import 'package:diving/Models/UserCourse.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../Controllers/UserCourseController.dart';
import '../../Models/User.dart';
import '../../Repository/UserCourseRepository.dart';
import '../../generated/locale_keys.g.dart';
import 'UserCoursesListPage.dart';


class CreateNewUserCoursePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CreateNewUserCoursePageState();
  }

  final User user;

  CreateNewUserCoursePage(this.user);
}

class _CreateNewUserCoursePageState extends State<CreateNewUserCoursePage> {
  static const engLanguage = "English";
  static const ukrLanguage = "Українська";

  bool wrongInput = false;

  final _userIdInputController = TextEditingController(text: "");
  final _courseIdInputController = TextEditingController(text: "");
  final _availableInputController = TextEditingController(text: "");
  final _completedInputController = TextEditingController(text: "");
  final _promoCodeIdInputController = TextEditingController(text: "");
  final _totalPriceInputController = TextEditingController(text: "");

  var userCourseController = UserCourseController(UserCourseRepository());

  List<dynamic> data = [];
  bool available = false;

  UserCourse? createNewUserCourse() {
    if(_availableInputController.text == 'true')
      available = true;

    data.add(int.tryParse(_userIdInputController.text));
    data.add(int.tryParse(_courseIdInputController.text));
    data.add(available);
    data.add(int.tryParse(_completedInputController.text));
    data.add(int.tryParse(_promoCodeIdInputController.text));
    data.add(double.tryParse(_totalPriceInputController.text));

    for (int i = 0; i < 5; i ++) {
      if (data[i] == null) {
        wrongInput = true;
      }
    }

    if (wrongInput == false && double.tryParse(_totalPriceInputController.text) != null) {

      UserCourse userCourse = new UserCourse(
        0,
        data[0] as int,
        data[1] as int,
        data[2] as bool,
        data[3] as int,
        data[4],
        data[5] as double,
      );
      return userCourse;
    } else {
      return null;
    }
  }

  Widget inputInformationComponent(String text, TextEditingController input, String label) {
    return Container(
      height: 50,
      width: 300,
      margin: EdgeInsetsDirectional.fromSTEB(50, 40, 50, 0),
      padding: EdgeInsetsDirectional.fromSTEB(20, 2, 10, 5),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: text,
          border: InputBorder.none,
          filled: false,
          labelText: label,
          labelStyle: TextStyle(fontSize: 16, height: 50),
        ),
        controller: input,
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
    inputInformationComponent("", _userIdInputController, LocaleKeys.user_id.tr()),
    inputInformationComponent("", _courseIdInputController, LocaleKeys.course_id.tr()),
    inputInformationComponent("", _availableInputController, LocaleKeys.available.tr()),
  ];
  List<Widget> userInformationBar2() => [
    inputInformationComponent("", _completedInputController, LocaleKeys.completed.tr()),
    inputInformationComponent("", _promoCodeIdInputController, LocaleKeys.promo_code_id.tr()),
    inputInformationComponent("", _totalPriceInputController, LocaleKeys.total_price.tr()),
  ];

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
                        return UserCoursesListPage(widget.user);
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
                  child: Text(
                    LocaleKeys.creating_new_record.tr(),
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 50),
                  ),
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
                        children: userInformationBar2(),
                      ),
                    )
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
                      if (wrongInput == true) {
                        return showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                    LocaleKeys.some_data_is_wrong.tr()),
                              );
                            });
                      } else {
                        if (createNewUserCourse() == null) {
                          return showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(LocaleKeys.wrong_input_data.tr()),
                                );
                              });
                        } else {
                          await userCourseController.postUserCourse(createNewUserCourse()!);
                          return showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(LocaleKeys.success.tr()),
                                );
                              });
                        }
                      }
                    },
                    child: Text(
                      LocaleKeys.create.tr(),
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
