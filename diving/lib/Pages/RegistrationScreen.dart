import 'package:diving/Repository/UserRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import '../Controllers/UserController.dart';
import '../Models/User.dart';
import 'LoginScreen.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegistrationScreenState();
  }
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  static const engLanguage = "English";
  static const ukrLanguage = "Українська";
  var curLanguage = "English";

  bool wrongInput = false;

  final _nameController = TextEditingController(text: "");
  final _surnameController = TextEditingController(text: "");
  final _ageController = TextEditingController(text: "");
  final _loginController = TextEditingController(text: "");
  final _passwordController = TextEditingController(text: "");

  var userController = UserController(UserRepository());

  User? register(){

    List<String> data = [];
    data.add(_nameController.text);
    data.add(_surnameController.text);
    data.add(_loginController.text);
    data.add(_passwordController.text);
    data.add(_ageController.text);

    for(int i = 0; i < 4; i++){
      if(data[i].length < 2){
        wrongInput = true;
      }
    }

    if(wrongInput == false){
      User user = new User(
        0,
        _loginController.text,
        _passwordController.text,
        _nameController.text,
        _surnameController.text,
        int.parse(_ageController.text),
        0,
        0,
        '',
        'no',
          'Номер телефону не вказаний',
        0,
        0
      );
      return user;
    }else{
      return null;

    }

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(0, 0, 0, 1.0),
            centerTitle: true,
            title: Text(
                LocaleKeys.you_should_authorize_to_use_this_web_site.tr()),
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
                    child: Text(engLanguage, style: TextStyle(color: Colors.white)),
                    value: engLanguage,
                  )
                ],
                onSelected: (String newValue){
                  setState(() {
                    curLanguage = newValue;
                  });
                },
                color: Colors.black,
                child: Icon(Icons.location_on),
              )
            ],
          ),
          body: SafeArea(
            child: Container(
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
                      LocaleKeys.registration.tr(),
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 50),
                    ),
                  ),
                  Container(
                    height: 50,
                    margin: EdgeInsetsDirectional.fromSTEB(500, 40, 500, 0),
                    padding: EdgeInsetsDirectional.fromSTEB(20, 2, 10, 5),
                    child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: LocaleKeys.enter_your_login.tr(),
                          filled: false,
                        ),
                        controller: _loginController,
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
                  ),
                  Container(
                    height: 50,
                    margin: EdgeInsetsDirectional.fromSTEB(500, 35, 500, 0),
                    padding: EdgeInsetsDirectional.fromSTEB(20, 2, 10, 5),
                    child: TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: LocaleKeys.enter_your_password.tr(),
                        filled: false,
                      ),
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
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    margin: EdgeInsetsDirectional.fromSTEB(500, 35, 500, 0),
                    padding: EdgeInsetsDirectional.fromSTEB(20, 2, 10, 5),
                    child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: LocaleKeys.enter_your_name.tr(),
                          filled: false,
                        ),
                        controller: _nameController,
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
                  ),
                  Container(
                    height: 50,
                    margin: EdgeInsetsDirectional.fromSTEB(500, 35, 500, 0),
                    padding: EdgeInsetsDirectional.fromSTEB(20, 2, 10, 5),
                    child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: LocaleKeys.enter_your_surname.tr(),
                          filled: false,
                        ),
                        controller: _surnameController,
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
                  ),
                  Container(
                    height: 50,
                    margin: EdgeInsetsDirectional.fromSTEB(500, 35, 500, 0),
                    padding: EdgeInsetsDirectional.fromSTEB(20, 2, 10, 5),
                    child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: LocaleKeys.enter_your_age.tr(),
                          filled: false,
                        ),
                        controller: _ageController,
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
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsetsDirectional.fromSTEB(525, 7, 10, 5),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(context,
                                MaterialPageRoute(builder: (BuildContext context) {
                                  return LoginScreen();
                                }), (route) => false);
                          },
                          child: Text(
                            LocaleKeys.do_you_have_an_account.tr(),
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        margin: EdgeInsetsDirectional.fromSTEB(0, 0, 40, 0),
                      ),
                    ],
                  ),
                  Container(
                    height: 40,
                    width: 180,
                    margin: EdgeInsetsDirectional.fromSTEB(100, 25, 100, 0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                      ),
                      onPressed: () async{
                        if(register() == null){
                          return showDialog(context: context, builder: (context){
                            return AlertDialog(title: Text(LocaleKeys.data_cant_be_empty_or_less_than_3_liters.tr()),);
                          });
                        }
                        else{
                          try{
                            await userController.registration(register()!);

                            Navigator.pushAndRemoveUntil(context,
                                MaterialPageRoute(builder: (BuildContext context) {
                                  return LoginScreen();
                                }), (route) => false);
                          }catch(ex){
                            return showDialog(context: context, builder: (context){
                              return AlertDialog(title: Text(ex.toString()),);
                            });
                          }


                        }
                      },
                      child: Text(LocaleKeys.register.tr(),style: TextStyle(color: Colors.white, fontSize: 15),),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
