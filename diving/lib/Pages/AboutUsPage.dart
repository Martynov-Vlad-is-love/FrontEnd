import 'package:diving/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../Controllers/UserController.dart';
import '../Models/User.dart';
import '../Repository/UserRepository.dart';
import 'AdminPages/AdminHomePage.dart';
import 'UserPages/HomePage.dart';

class AboutUsPage extends StatefulWidget {
  @override
  _AboutUsPage createState() => _AboutUsPage();
  final User user;

  AboutUsPage(this.user);
}

class _AboutUsPage extends State<AboutUsPage> {
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
    return MaterialApp(
      home: Scaffold(
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
                    if (widget.user.roleId == 2)
                      return AdminHomePage(widget.user);
                    else
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
                    child: Text(LocaleKeys.about_us.tr(),
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 50),
                    ),
                  ),
                  Container(
                    width: 1000,
                    height: 200,
                    margin: EdgeInsetsDirectional.fromSTEB(50, 40, 50, 0),
                    padding: EdgeInsetsDirectional.fromSTEB(50, 30, 50, 30),
                    child: Text(LocaleKeys.about_us_page.tr(),
                      style: TextStyle(fontSize: 30),
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
                ],
              ),
            ),
          )),
    );
  }
}
