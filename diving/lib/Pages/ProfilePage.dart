import 'package:diving/Controllers/UserController.dart';
import 'package:diving/Repository/UserRepository.dart';
import 'package:diving/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../Models/User.dart';
import 'AdminPages/AdminHomePage.dart';
import 'UserPages/HomePage.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }

  final User user;

  ProfilePage(this.user);
}

class _ProfilePageState extends State<ProfilePage> {
  static const engLanguage = "English";
  static const ukrLanguage = "Українська";

  final _nameInput = TextEditingController(text: "");
  final _diseaseInput = TextEditingController(text: "");
  final _surnameController = TextEditingController(text: "");
  final _phoneNumberInput = TextEditingController(text: "");
  final _ageInput = TextEditingController(text: "");
  final _passwordInput = TextEditingController(text: "");
  final _loginInput = TextEditingController(text: "");
  final _repeatedPasswordInput = TextEditingController(text: "");

  bool wrongInput = false;
  bool checkPassword = true;

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
        inputInformationComponent(
            widget.user.login ?? "", _loginInput, LocaleKeys.login.tr()),
        inputInformationComponent(
            widget.user.password ?? "", _passwordInput, LocaleKeys.password.tr()),
        inputInformationComponent(widget.user.password ?? "",
            _repeatedPasswordInput, LocaleKeys.repeat_password.tr()),
        inputInformationComponent(
            widget.user.phoneNumber ?? "", _phoneNumberInput, LocaleKeys.phone_number.tr()),
      ];

  List<Widget> userInformationBar2() => [
        inputInformationComponent(widget.user.name ?? "", _nameInput, LocaleKeys.name.tr()),
        inputInformationComponent(
            widget.user.surname ?? "", _surnameController, LocaleKeys.surname.tr()),
        inputInformationComponent(widget.user.age.toString(), _ageInput, LocaleKeys.surname.tr()),
        inputInformationComponent(
            widget.user.disease ?? "", _diseaseInput, LocaleKeys.disease.tr()),
      ];

  void save() {
    if (_nameInput.text.length > 2)
      widget.user.name = _nameInput.text;
    else if (_nameInput.text.isNotEmpty) wrongInput = true;

    if (_surnameController.text.length > 2)
      widget.user.surname = _surnameController.text;
    else if (_surnameController.text.isNotEmpty) wrongInput = true;

    if (_ageInput.text.length > 0 &&
        int.tryParse(_ageInput.text) != null &&
        int.tryParse(_ageInput.text)! > 7)
      widget.user.age = int.tryParse(_ageInput.text);
    else if (_ageInput.text.isNotEmpty) wrongInput = true;

    if (_phoneNumberInput.text.length > 2)
      widget.user.phoneNumber = _phoneNumberInput.text;
    else if (_phoneNumberInput.text.isNotEmpty) wrongInput = true;

    if (_loginInput.text.length > 2)
      widget.user.login = _loginInput.text;
    else if (_loginInput.text.isNotEmpty) wrongInput = true;

    if (_diseaseInput.text.length > 2)
      widget.user.disease = _diseaseInput.text;
    else if (_diseaseInput.text.isNotEmpty) wrongInput = true;

    if (_passwordInput.text.isNotEmpty &&
        _repeatedPasswordInput.text.isNotEmpty) {
      if (_passwordInput.text == _repeatedPasswordInput.text &&
          _passwordInput.text.length > 3) {
        widget.user.password = _passwordInput.text;
      } else {
        checkPassword = false;
      }
    }
  }

  var userController = UserController(UserRepository());

  @override
  Widget build(BuildContext context) {
    var curLanguage = language(widget.user.languageId!);
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(0, 0, 0, 1.0),
            centerTitle: true,
            title: const Text('ProDiver'),
            actions: [
              PopupMenuButton(
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                      value: ukrLanguage,
                      child: Text(
                        ukrLanguage,
                        style: TextStyle(color: Colors.white),
                      )),
                  PopupMenuItem(
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
                    if (widget.user.roleId == 2)
                      return AdminHomePage(widget.user);
                    else
                      return HomePage(widget.user);
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
                  child: Text(LocaleKeys.your_profile.tr(),
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
                          children: userInformationBar2()),
                    ),
                  ],
                ),
                Container(
                  width: 250,
                  height: 35,
                  margin: EdgeInsetsDirectional.fromSTEB(50, 40, 50, 0),
                  padding: EdgeInsetsDirectional.fromSTEB(20, 2, 10, 5),
                  child: Center(
                      child: Text(plural(LocaleKeys.your_hours_under_water_, widget.user.hoursUnderWater!))),
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
                                    LocaleKeys.data_cant_be_empty_or_less_than_2_liters.tr()),
                              );
                            });
                      } else if (!checkPassword) {
                        return showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(LocaleKeys.passwords_should_be_equal.tr()),
                              );
                            });
                      } else {
                        if (widget.user.id == null) {
                          print(LocaleKeys.user_not_found.tr());
                        } else if (widget.user.id != null) {
                          await userController.updateUserData(widget.user);
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
