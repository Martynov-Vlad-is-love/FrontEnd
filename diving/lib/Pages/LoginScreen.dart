import 'package:diving/Repository/UserRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Models/User.dart';
import 'HomePage.dart';
import 'RegistrationScreen.dart';

class LoginScreen extends StatefulWidget {
  final userRepository = UserRepository();
  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  String _loginInput = "";
  String _valueToShow = "";
  String _value = "";
  static const engLanguage = "English";
  static const ukrLanguage = "Українська";
  var curLanguage = "English";

  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(0, 0, 0, 1.0),
          centerTitle: true,
          title: const Text(
              'Для того щоб скористуватися сайтом потрібно пройти аутентифікацію'),
          actions: [
            PopupMenuButton(
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                    child: Text(
                      'Українська',
                      style: TextStyle(color: Colors.white),
                    )),
                PopupMenuItem(
                    child:
                    Text('English', style: TextStyle(color: Colors.white))),
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
                  "Авторизація",
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
                      hintText: "Введіть логин",
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
                    hintText: "Введіть пароль",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsetsDirectional.fromSTEB(100, 7, 10, 5),
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Забули пароль?",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                    margin: EdgeInsetsDirectional.fromSTEB(0, 0, 40, 0),
                  ),
                  Container(
                    padding: EdgeInsetsDirectional.fromSTEB(200, 7, 65, 5),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return RegistrationScreen();
                        }), (route) => false);
                      },
                      child: Text(
                        "Зареєструватися",
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
                    print(passwordController.text);
                    User? user = await widget.userRepository.authentication(_loginInput, passwordController.text);
                    if(user == null){
                      return showDialog(context: context, builder: (context){
                        return AlertDialog(title: Text("Wrong login or password"),);
                      });
                    }
                    else{
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                            return HomePage();
                          }), (route) => false);
                    }
                  },
                  child: Text('Авторизуватися',style: TextStyle(color: Colors.white, fontSize: 15),),
                ),
              )
            ],
          ),
        ));
  }
}
