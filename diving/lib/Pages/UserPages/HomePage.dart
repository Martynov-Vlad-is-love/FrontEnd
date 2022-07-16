import 'package:diving/Pages/LoginScreen.dart';
import 'package:diving/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../Models/User.dart';
import '../AboutUsPage.dart';
import '../ProfilePage.dart';
import 'CoursesPage.dart';
import 'OwnCoursesPage.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }

  final User user;

  HomePage(this.user);
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => SimpleDialog(
                          title:
                              Text(LocaleKeys.do_you_really_want_to_leave.tr()),
                          contentPadding: const EdgeInsets.all(20.0),
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) {
                                    return LoginScreen();
                                  }), (route) => false);
                                },
                                child: Text(LocaleKeys.yes.tr())),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(LocaleKeys.no.tr()))
                          ],
                        ));
              },
            ),
            backgroundColor: Color.fromRGBO(0, 0, 0, 1.0),
            centerTitle: true,
            actions: [
              PopupMenuButton(
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                      onTap: () async {
                        await context.setLocale(Locale('uk'));
                      },
                      child: Text(
                        'Українська',
                        style: TextStyle(color: Colors.white),
                      )),
                  PopupMenuItem(
                      onTap: () async {
                        await context.setLocale(Locale('en'));
                      },
                      child: Text('English',
                          style: TextStyle(color: Colors.white))),
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
                                      return CoursesPage(widget.user);
                                    }), (route) => false);
                                  },
                                  style: TextButton.styleFrom(
                                      fixedSize: Size(500, 500)),
                                  child: Text(
                                    LocaleKeys.courses.tr(),
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
                                    LocaleKeys.profile.tr(),
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
                                    LocaleKeys.about_us.tr(),
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
                                  onPressed: () async {
                                    Navigator.pushAndRemoveUntil(context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) {
                                      return OwnCoursesPage(widget.user);
                                    }), (route) => false);
                                  },
                                  style: TextButton.styleFrom(
                                      fixedSize: Size(500, 500)),
                                  child: Text(
                                    LocaleKeys.purchased_courses.tr(),
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
          )),
    );
  }
}
