import 'package:diving/Controllers/UserController.dart';
import 'package:diving/Repository/UserRepository.dart';
import 'package:diving/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Controllers/UserCourseController.dart';
import '../../Models/User.dart';
import '../../Models/UserCourse.dart';
import '../../Repository/UserCourseRepository.dart';

import 'UserCoursesListPage.dart';

class EditingUserCoursesInfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EditingUserCoursesInfoPageState();
  }

  final User user;
  final UserCourse userCourseToEdit;

  EditingUserCoursesInfoPage(this.user, this.userCourseToEdit);

}

class _EditingUserCoursesInfoPageState extends State<EditingUserCoursesInfoPage> {
  static const engLanguage = "English";
  static const ukrLanguage = "Українська";

  final _userIdInputController = TextEditingController(text: "");
  final _courseIdInputController = TextEditingController(text: "");
  final _availableInputController = TextEditingController(text: "");
  final _completedInputController = TextEditingController(text: "");
  final _promoCodeIdInputController = TextEditingController(text: "");
  final _totalPriceInputController = TextEditingController(text: "");

  bool wrongInput = false;

  final userController = UserController(UserRepository());

  Widget inputInformationComponent(
      String text, TextEditingController input, String label) {
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
    inputInformationComponent(widget.userCourseToEdit.userId.toString(), _userIdInputController, LocaleKeys.user_id.tr()),
    inputInformationComponent(widget.userCourseToEdit.courseId.toString(), _courseIdInputController, LocaleKeys.course_id.tr()),
    inputInformationComponent(widget.userCourseToEdit.available.toString(), _availableInputController, LocaleKeys.available.tr()),
  ];
  List<Widget> userInformationBar2() => [
    inputInformationComponent(widget.userCourseToEdit.completed.toString(), _completedInputController, LocaleKeys.completed.tr()),
    inputInformationComponent(widget.userCourseToEdit.promoCodeId.toString(), _promoCodeIdInputController, LocaleKeys.promo_code.tr()),
    inputInformationComponent(widget.userCourseToEdit.totalPrice.toString(), _totalPriceInputController, LocaleKeys.total_price.tr()),
  ];

  void save() {

    if (_userIdInputController.text.length > 0 && int.tryParse(_userIdInputController.text) != null)
      widget.userCourseToEdit.userId = int.tryParse(_userIdInputController.text);
    else if(_userIdInputController.text.isNotEmpty)
      wrongInput = true;

    if (_courseIdInputController.text.length > 0 && int.tryParse(_courseIdInputController.text) != null)
      widget.userCourseToEdit.courseId = int.tryParse(_courseIdInputController.text);
    else if(_courseIdInputController.text.isNotEmpty)
      wrongInput = true;

    if (_availableInputController.text.length > 0)
      if(_availableInputController.text == "true")
        widget.userCourseToEdit.available = true;
      else if(_availableInputController.text == "false")
        widget.userCourseToEdit.available = false;
      else
        wrongInput = true;
    else if(_availableInputController.text.isNotEmpty)
      wrongInput = true;

    if (_completedInputController.text.length > 0 && int.tryParse(_completedInputController.text) != null)
      widget.userCourseToEdit.completed = int.tryParse(_completedInputController.text);
    else if(_completedInputController.text.isNotEmpty)
      wrongInput = true;

    if (_promoCodeIdInputController.text.length > 0 && int.tryParse(_promoCodeIdInputController.text) != null)
      widget.userCourseToEdit.promoCodeId = int.tryParse(_promoCodeIdInputController.text);
    else if(_promoCodeIdInputController.text.isNotEmpty)
      wrongInput = true;

    if (_totalPriceInputController.text.length > 0 && double.tryParse(_totalPriceInputController.text) != null)
      widget.userCourseToEdit.totalPrice = double.tryParse(_totalPriceInputController.text);
    else if(_totalPriceInputController.text.isNotEmpty)
      wrongInput = true;
  }

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
                        widget.user.languageId = 0;
                        await userController.updateUserData(widget.user);
                      },
                      value: ukrLanguage,
                      child: Text(
                        ukrLanguage,
                        style: TextStyle(color: Colors.white),
                      )),
                  PopupMenuItem(
                    onTap: () async{
                      await context.setLocale(Locale('en'));
                      widget.user.languageId = 1;
                      await userController.updateUserData(widget.user);
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
                    plural(LocaleKeys.editing_record_, widget.userCourseToEdit.id!),
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
                      save();
                      if (wrongInput == true) {
                        return showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                    LocaleKeys.some_data_is_wrong.tr()),
                              );
                            });
                      }
                      else {
                        if (widget.userCourseToEdit.id == null) {
                          print(LocaleKeys.user_course_not_found.tr());
                        } else if (widget.userCourseToEdit.id != null) {
                          await userCourseController.updateUserCourseData(widget.userCourseToEdit);
                          return showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                      LocaleKeys.success.tr()),
                                );
                              });
                        }
                      }
                    },
                    child: Text(
                      LocaleKeys.save.tr(),
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
