import 'package:diving/Controllers/UserController.dart';
import 'package:diving/Repository/UserRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Models/User.dart';
import 'HomePage.dart';
import 'LoginScreen.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }

  final User user;

  ProfilePage(this.user);
}

class _ProfilePageState extends State<ProfilePage> {
  String _nameInput = "";
  int _hoursUnderWater = 0;
  String _surnameInput = "";
  final _surnameController = TextEditingController();
  String _phoneNumberInput = "";
  int _ageInput = 0;
  String _passwordInput = "";
  String _loginInput = "";

  static const engLanguage = "English";
  static const ukrLanguage = "Українська";
  var curLanguage = "English";

  Widget inputInformationComponent(String text, String input) {
    return Container(
      height: 50,
      width: 300,
      margin: EdgeInsetsDirectional.fromSTEB(50, 40, 50, 0),
      padding: EdgeInsetsDirectional.fromSTEB(20, 2, 10, 5),
      child: TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: text,
            filled: false,
          ),
          onChanged: (String val) {
            input = val;
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
    );
  }

  List<Widget> userInformationBar1() => [
        inputInformationComponent(widget.user.login ?? "", _loginInput),
        inputInformationComponent(widget.user.password ?? "", _passwordInput),
        inputInformationComponent(widget.user.phoneNumber ?? "", _phoneNumberInput),
      ];

  List<Widget> userInformationBar2() => [
        inputInformationComponent(widget.user.name ?? "", _nameInput),
        inputInformationComponent(widget.user.surname ?? "", _surnameController.text),
        inputInformationComponent(widget.user.age.toString(), _ageInput.toString()),
      ];

  void save(String _nameInput, String _surnameInput,int _ageInput, String _phoneNumberInput, String _loginInput, String _passwordInput) {
    if (_nameInput.isNotEmpty) widget.user.name = _nameInput ;
    if (_surnameInput.isNotEmpty)widget.user.surname = _surnameController.text;
    if (_ageInput != 0)widget.user.age = _ageInput;
    if (_phoneNumberInput.isNotEmpty) widget.user.phoneNumber = _phoneNumberInput;
    if (_loginInput.isNotEmpty)widget.user.login = _loginInput;
    if (_passwordInput.isNotEmpty)widget.user.password = _passwordInput;
  }

  var userController = UserController(UserRepository());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: Text(
                  "Your profile",
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
                    child: Text('Ваш час під водою: ${widget.user.hoursUnderWater} годин')),
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
                    save(_nameInput,_surnameInput,_ageInput, _phoneNumberInput, _loginInput, _passwordInput);
                    if(widget.user.id == null){
                      print("User not found");
                    }
                    else if(widget.user.id != null){
                      await userController.updateUserData(widget.user);
                    }
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
