import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'HomePage.dart';
import 'LoginScreen.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  String _nameInput = "";
  int _hoursUnderWater = 0;
  String _surnameInput = "";
  String _phoneNumberInput = "";
  int _ageInput = 0;
  String _passwordInput = "";
  String _loginInput = "";
  String _valueToShow = "";
  String _value = "";
  static const engLanguage = "English";
  static const ukrLanguage = "Українська";
  var curLanguage = "English";

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
                  return HomePage();
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
                      children: [
                        Container(
                          height: 50,
                          width: 300,
                          margin: EdgeInsetsDirectional.fromSTEB(50, 40, 50, 0),
                          padding: EdgeInsetsDirectional.fromSTEB(20, 2, 10, 5),
                          child: TextFormField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Введіть логін",
                                filled: false,
                              ),
                              onChanged: (String val) {
                                _loginInput = val;
                              }),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              color: Colors.redAccent,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black54.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 5,
                                  offset: Offset(
                                      0, 1), // changes position of shadow
                                ),
                              ]),
                        ),
                        Container(
                          width: 300,
                          height: 50,
                          margin: EdgeInsetsDirectional.fromSTEB(50, 40, 50, 0),
                          padding: EdgeInsetsDirectional.fromSTEB(20, 2, 10, 5),
                          child: TextFormField(
                            controller: TextEditingController.fromValue(
                                TextEditingValue(
                                    text: _valueToShow,
                                    selection: new TextSelection.collapsed(
                                        offset: _valueToShow.length))),
                            onChanged: (String val) {
                              String value = "";
                              if (val.length > _passwordInput.length) {
                                value += val.substring(
                                    _passwordInput.length, val.length);
                              }
                              if (val.length < _passwordInput.length) {
                                value = _value.substring(1, val.length);
                              }
                              String valueToShow = "*" * val.length;
                              setState(() {
                                _valueToShow = valueToShow;
                                _passwordInput = value;
                              });
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Введіть пароль",
                              filled: false,
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                            color: Colors.redAccent,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black54.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 1), // changes position of shadow
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 300,
                          margin: EdgeInsetsDirectional.fromSTEB(50, 40, 50, 0),
                          padding: EdgeInsetsDirectional.fromSTEB(20, 2, 10, 5),
                          child: TextFormField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Введіть номер телефону",
                                filled: false,
                              ),
                              onChanged: (String val) {
                                _phoneNumberInput = val;
                              }),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              color: Colors.redAccent,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black54.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 5,
                                  offset: Offset(
                                      0, 1), // changes position of shadow
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Container(
                          width: 300,
                          height: 50,
                          margin: EdgeInsetsDirectional.fromSTEB(50, 40, 50, 0),
                          padding: EdgeInsetsDirectional.fromSTEB(20, 2, 10, 5),
                          child: TextFormField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Введіть ім'я",
                                filled: false,
                              ),
                              onChanged: (String val) {
                                _nameInput = val;
                              }),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              color: Colors.redAccent,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black54.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 5,
                                  offset: Offset(
                                      0, 1), // changes position of shadow
                                ),
                              ]),
                        ),
                        Container(
                          width: 300,
                          height: 50,
                          margin: EdgeInsetsDirectional.fromSTEB(50, 40, 50, 0),
                          padding: EdgeInsetsDirectional.fromSTEB(20, 2, 10, 5),
                          child: TextFormField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Введіть прізвище",
                                filled: false,
                              ),
                              onChanged: (String val) {
                                _surnameInput = val;
                              }),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              color: Colors.redAccent,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black54.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 5,
                                  offset: Offset(
                                      0, 1), // changes position of shadow
                                ),
                              ]),
                        ),
                        Container(
                          width: 300,
                          height: 50,
                          margin: EdgeInsetsDirectional.fromSTEB(50, 40, 50, 0),
                          padding: EdgeInsetsDirectional.fromSTEB(20, 2, 10, 5),
                          child: TextFormField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Введіть ваш вік",
                                filled: false,
                              ),
                              onChanged: (String val) {
                                _ageInput = int.parse(val);
                              }),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              color: Colors.redAccent,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black54.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 5,
                                  offset: Offset(
                                      0, 1), // changes position of shadow
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                width: 250,
                height: 35,
                margin: EdgeInsetsDirectional.fromSTEB(50, 40, 50, 0),
                padding: EdgeInsetsDirectional.fromSTEB(20, 2, 10, 5),
                child:
                    Center(child: Text('Ваш час під водою: $_hoursUnderWater годин')),
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
                  onPressed: () {},
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
