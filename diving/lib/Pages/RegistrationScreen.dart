import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegistrationScreenState();
  }
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String _loginInput = "";
  String _valueToShow = "";
  String _value = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(0, 0, 0, 1.0),
          centerTitle: true,
          title: const Text(
              'Для того щоб скористуватися сайтом потрібно пройти аутентифікацію'),
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
                  "Реєстрація",
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
                  controller: TextEditingController.fromValue(TextEditingValue(
                      text: _valueToShow,
                      selection: new TextSelection.collapsed(
                          offset: _valueToShow.length))),
                  onChanged: (String val) {
                    String value = "";
                    if (val.length > _loginInput.length) {
                      value += val.substring(_loginInput.length, val.length);
                    }
                    if (val.length < _loginInput.length) {
                      value = _value.substring(1, val.length);
                    }
                    String valueToShow = "*" * val.length;
                    setState(() {
                      _valueToShow = valueToShow;
                      _loginInput = value;
                    });
                  },
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
              Container(
                height: 50,
                margin: EdgeInsetsDirectional.fromSTEB(500, 35, 500, 0),
                padding: EdgeInsetsDirectional.fromSTEB(20, 2, 10, 5),
                child: TextFormField(
                  controller: TextEditingController.fromValue(TextEditingValue(
                      text: _valueToShow,
                      selection: new TextSelection.collapsed(
                          offset: _valueToShow.length))),
                  onChanged: (String val) {
                    String value = "";
                    if (val.length > _loginInput.length) {
                      value += val.substring(_loginInput.length, val.length);
                    }
                    if (val.length < _loginInput.length) {
                      value = _value.substring(1, val.length);
                    }
                    String valueToShow = "*" * val.length;
                    setState(() {
                      _valueToShow = valueToShow;
                      _loginInput = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Введіть пароль ще раз",
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
                margin: EdgeInsetsDirectional.fromSTEB(500, 60, 500, 0),
                padding: EdgeInsetsDirectional.fromSTEB(20, 2, 10, 5),
                child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Введіть ім'я",
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
                margin: EdgeInsetsDirectional.fromSTEB(500, 60, 500, 0),
                padding: EdgeInsetsDirectional.fromSTEB(20, 2, 10, 5),
                child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Введіть прізвище",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsetsDirectional.fromSTEB(100, 7, 10, 5),
                    child: TextButton(
                      onPressed: () {

                      },
                      child: Text(
                        "Вже є аккаунт?",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                    margin: EdgeInsetsDirectional.fromSTEB(0, 0, 40, 0),
                  ),
                  Container(
                    padding: EdgeInsetsDirectional.fromSTEB(200, 7, 65, 5),
                    child: TextButton(
                      onPressed: () {
                      },
                      child: Text(
                        "Зареєструватися",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                    margin: EdgeInsetsDirectional.fromSTEB(0, 0, 40, 0),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
