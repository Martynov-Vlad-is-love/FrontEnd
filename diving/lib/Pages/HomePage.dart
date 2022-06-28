import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CoursesPage.dart';
import 'ProfilePage.dart';
import 'AboutUsPage.dart';
import 'RegistrationScreen.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  String _loginInput = "";
  String _valueToShow = "";
  String _value = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(0, 0, 0, 1.0),
          centerTitle: true,
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
          title: const Text('ProDiver'),
        ),
        body: SingleChildScrollView(
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 500,
                        height: 500,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.deepPurpleAccent,
                            Colors.red,
                          ],
                        )),
                        child: Center(
                            child: TextButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) {
                                    return CoursesPage();
                                  }), (route) => false);
                                },
                                style: TextButton.styleFrom(
                                    fixedSize: Size(500, 500)),
                                child: Text(
                                  'Courses',
                                  style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black),
                                ))),
                        margin: EdgeInsets.fromLTRB(30, 30, 30, 30),
                      ),
                      Container(
                        width: 500,
                        height: 500,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.amber,
                            Colors.blueAccent,
                          ],
                        )),
                        child: Center(
                            child: TextButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return ProfilePage();
                                          }), (route) => false);
                                },
                                style: TextButton.styleFrom(
                                    fixedSize: Size(500, 500)),
                                child: Text(
                                  'Profile',
                                  style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black),
                                ))),
                        margin: EdgeInsets.fromLTRB(30, 30, 30, 30),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 500,
                        height: 500,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.teal,
                            Colors.pink,
                          ],
                        )),
                        child: Center(
                            child: TextButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return AboutUsPage();
                                          }), (route) => false);
                                },
                                style: TextButton.styleFrom(
                                    fixedSize: Size(500, 500)),
                                child: Text(
                                  'About us',
                                  style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black),
                                ))),
                        margin: EdgeInsets.fromLTRB(30, 30, 30, 30),
                      ),
                      Container(
                        width: 500,
                        height: 500,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.deepPurpleAccent,
                            Colors.deepOrange,
                          ],
                        )),
                        child: Center(
                            child: TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                    fixedSize: Size(500, 500)),
                                child: Text(
                                  'Contacts',
                                  style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black),
                                ))),
                        margin: EdgeInsets.fromLTRB(30, 30, 30, 30),
                      )
                    ],
                  )
                ],
              )),
        ));
  }
}
