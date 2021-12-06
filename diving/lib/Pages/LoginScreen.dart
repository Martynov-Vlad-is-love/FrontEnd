import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  String _loginInput = "";

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
                height: 50,
                margin: EdgeInsetsDirectional.fromSTEB(40, 130, 40, 0),
                padding: EdgeInsetsDirectional.fromSTEB(20, 5, 10, 5),
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
                ),
              ),
              Container(
                height: 50,
                margin: EdgeInsetsDirectional.fromSTEB(40, 130, 40, 0),
                padding: EdgeInsetsDirectional.fromSTEB(20, 5, 10, 5),
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
                ),
              ),
            ],
          ),
        ));
  }
}
