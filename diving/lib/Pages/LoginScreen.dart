import 'package:diving/Controllers/UserController.dart';
import 'package:diving/Pages/AdminPages/AdminHomePage.dart';
import 'package:diving/Repository/UserRepository.dart';
import 'package:flutter/material.dart';
import '../generated/locale_keys.g.dart';
import '../Models/User.dart';
import 'RegistrationScreen.dart';
import 'UserPages/HomePage.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  String _loginInput = "";
  bool _security = true;
  static const engLanguage = "English";
  static const ukrLanguage = "Українська";
  var curLanguage = "English";

  final userController = UserController(UserRepository());
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    try{


    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(0, 0, 0, 1.0),
            centerTitle: true,
            title: Text(
                LocaleKeys.you_should_authorize_to_use_this_web_site.tr(),
              style: TextStyle(fontSize: 20),
            ),
            actions: [
              PopupMenuButton(
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                    onTap: () async{
                      await context.setLocale(Locale('uk'));
                    },
                      child: Text(
                        'Українська',
                        style: TextStyle(color: Colors.white),
                      )),
                  PopupMenuItem(
                    onTap: () async{
                      await context.setLocale(Locale('en'));
                    },
                      child: Text(
                          'English',
                          style: TextStyle(color: Colors.white))
                  ),
                ],
                color: Colors.black,
                child: Icon(Icons.location_on),
              )
            ],
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
                  margin: EdgeInsetsDirectional.fromSTEB(30, 75, 40, 0),
                  child: Text(
                    LocaleKeys.authorization.tr(),
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 50),
                  ),
                ),
                Container(
                  height: 50,
                  margin: EdgeInsetsDirectional.fromSTEB(500, 60, 500, 0),
                  padding: EdgeInsetsDirectional.fromSTEB(20, 2, 10, 5),
                  child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: LocaleKeys.login.tr(),
                        filled: false,
                      ),
                      onChanged: (String val) {
                        _loginInput = val;

                      }),
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

                    controller: passwordController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: LocaleKeys.password.tr(),
                      filled: false,
                      suffixIcon: IconButton(
                        icon: Icon(Icons.visibility, color: Colors.grey[900],),
                        onPressed: (){
                          setState((){
                            _security = !_security;
                          });
                      },
                      )
                    ),
                    obscureText: _security,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsetsDirectional.fromSTEB(525, 10, 65, 5),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (BuildContext context) {
                            return RegistrationScreen();
                          }), (route) => false);
                        },
                        child: Text(
                          LocaleKeys.registration.tr(),
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
                  margin: EdgeInsetsDirectional.fromSTEB(100, 35, 100, 0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    ),
                    onPressed: () async{
                      User? user = await userController.authentication(_loginInput, passwordController.text);
                      if(user == null){
                        return showDialog(context: context, builder: (context){
                          return AlertDialog(title: Text(LocaleKeys.wrong_login_or_password.tr()),);
                        });
                      }
                      else{
                        if(user.roleId == 2){
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (BuildContext context) {
                                return AdminHomePage(user);
                              }), (route) => false);
                        }
                        else{
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (BuildContext context) {
                                return HomePage(user);
                              }), (route) => false);
                        }
                      }
                    },
                    child: Text(LocaleKeys.authorize.tr(),style: TextStyle(color: Colors.white, fontSize: 15),),
                  ),
                )
              ],
            ),
          )),
    );
    }catch(ex){
      print(ex);
      return Container(color: Colors.indigo,);
    }
  }
}
