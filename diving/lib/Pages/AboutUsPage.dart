import 'package:diving/Repository/CourseRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Controllers/UserController.dart';
import '../Models/Course.dart';
import '../Models/User.dart';
import '../Repository/UserRepository.dart';
import 'HomePage.dart';


class AboutUsPage extends StatefulWidget{
  @override
  _AboutUsPage createState() => _AboutUsPage();
  final User user;

  AboutUsPage(this.user);
}

class _AboutUsPage extends State<AboutUsPage>{
  static const engLanguage = "English";
  static const ukrLanguage = "Українська";

  var userController = UserController(UserRepository());

  String language(int id) {
    if (id == 0) {
      return ukrLanguage;
    } else
      return engLanguage;
  }



  @override
  Widget build(BuildContext context) {
    var curLanguage = language(widget.user.languageId!);
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
          child: Center(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsetsDirectional.fromSTEB(30, 55, 40, 0),
                  child: Text(
                    "About us",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 50),
                  ),
                ),

                Container(
                  width: 250,
                  height: 35,
                  margin: EdgeInsetsDirectional.fromSTEB(50, 40, 50, 0),
                  padding: EdgeInsetsDirectional.fromSTEB(20, 2, 10, 5),
                  child: Center(

                      child: Text(
                          'Ваш час під водою: ${widget.user.hoursUnderWater} годин')),
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

                    },
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }


}