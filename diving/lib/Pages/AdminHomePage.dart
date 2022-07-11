import 'package:diving/Pages/UsersInfoPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Models/User.dart';
import 'CoursesPage.dart';
import 'LoginScreen.dart';
import 'ProfilePage.dart';
import 'AboutUsPage.dart';
import 'RegistrationScreen.dart';

class AdminHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AdminHomePageState();
  }
  final User user;
  AdminHomePage(this.user);
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.logout),
            onPressed: (){
              showDialog(context: context,
                  builder: (context) => SimpleDialog(
                    title: Text("Do you really want to leave?"),
                    contentPadding: const EdgeInsets.all(20.0),
                    children: [
                      TextButton(onPressed: (){
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                              return LoginScreen();
                            }), (route) => false);
                      }, child: const Text("Yes")),
                      TextButton(onPressed: (){
                        Navigator.of(context).pop();
                      }, child: const Text("No"))
                    ],
                  )
              );

            },
          ),
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
          title: const Text('ProDiver Admin'),
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
                                            return CoursesPage(widget.user);
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
                                            return ProfilePage(widget.user);
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
                                            return AboutUsPage(widget.user);
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
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(context,
                                      MaterialPageRoute(builder: (BuildContext context) {
                                        return UsersInfoPage(widget.user);
                                      }), (route) => false);
                                },
                                style: TextButton.styleFrom(
                                    fixedSize: Size(500, 500)),
                                child: Text(
                                  'Users',
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
