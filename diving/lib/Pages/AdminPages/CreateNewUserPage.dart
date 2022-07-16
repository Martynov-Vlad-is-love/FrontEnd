import 'package:diving/Controllers/UserController.dart';
import 'package:diving/Repository/UserRepository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../Models/User.dart';
import '../../generated/locale_keys.g.dart';
import 'UsersInfoPage.dart';

class CreateNewUserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CreateNewUserPageState();
  }

  final User user;


  CreateNewUserPage(this.user);
}

class _CreateNewUserPageState extends State<CreateNewUserPage> {
  static const engLanguage = "English";
  static const ukrLanguage = "Українська";

  bool wrongInput = false;

  final _roleIdInput = TextEditingController(text: "");
  final _nameInput = TextEditingController(text: "");
  final _diseaseInput = TextEditingController(text: "");
  final _surnameController = TextEditingController(text: "");
  final _phoneNumberInput = TextEditingController(text: "");
  final _ageInput = TextEditingController(text: "");
  final _passwordInput = TextEditingController(text: "");
  final _loginInput = TextEditingController(text: "");
  final _maxDepthInput = TextEditingController(text: "");
  final _hoursUnderWaterInput = TextEditingController(text: "");

  var userController = UserController(UserRepository());

  User? register() {
    List<String> data = [];
    data.add(_nameInput.text);
    data.add(_surnameController.text);
    data.add(_loginInput.text);
    data.add(_passwordInput.text);
    data.add(_ageInput.text);
    data.add(_phoneNumberInput.text);
    data.add(_maxDepthInput.text);
    data.add(_hoursUnderWaterInput.text);
    data.add(_diseaseInput.text);
    data.add(_roleIdInput.text);
    for (int i = 0; i < 9; i++) {
      if (data[i].length < 1) {
        wrongInput = true;
      }
    }

    if (wrongInput == false) {
    User user = new User(
          0,
          _loginInput.text,
          _passwordInput.text,
          _nameInput.text,
          _surnameController.text,
          int.parse(_ageInput.text),
          double.parse(_maxDepthInput.text),
          double.parse(_hoursUnderWaterInput.text),
          DateFormat("yyyy-MM-ddTHH:mm:ss.mmm").format(DateTime.now()),
          _diseaseInput.text,
          _phoneNumberInput.text,
          int.parse(_roleIdInput.text),
          0);
      return user;
    } else {
      return null;
    }
  }

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
        inputInformationComponent("", _loginInput, LocaleKeys.login.tr()),
        inputInformationComponent("", _passwordInput, LocaleKeys.password.tr()),
        inputInformationComponent("", _maxDepthInput, LocaleKeys.max_depth.tr()),
        inputInformationComponent("", _phoneNumberInput, LocaleKeys.phone_number.tr()),
        inputInformationComponent("", _roleIdInput, LocaleKeys.role_id_help.tr()),
      ];

  List<Widget> userInformationBar2() => [
        inputInformationComponent("", _nameInput, LocaleKeys.name.tr()),
        inputInformationComponent("", _surnameController, LocaleKeys.surname.tr()),
        inputInformationComponent("", _ageInput, LocaleKeys.age.tr()),
        inputInformationComponent("", _diseaseInput, LocaleKeys.disease.tr()),
        inputInformationComponent("", _hoursUnderWaterInput, LocaleKeys.hours_under_water.tr()),
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
                    return UsersInfoPage(widget.user);
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
                    LocaleKeys.creating_new_user.tr(),
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
                                    LocaleKeys.data_cant_be_empty_or_less_than_2_liters.tr()),
                              );
                            });
                      } else if (!checkPassword) {
                        return showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                    LocaleKeys.data_cant_be_empty_or_less_than_3_liters.tr()),
                              );
                            });
                      } else {
                        if (register() == null) {
                          return showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                      LocaleKeys.passwords_should_consist_more_than_3_symbols.tr()),
                                );
                              });
                        } else {
                          await userController.postUserData(register()!);
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
