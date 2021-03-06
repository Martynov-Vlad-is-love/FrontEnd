import 'package:diving/Controllers/UserController.dart';
import 'package:diving/Pages/UserPages/CourseInfoPage.dart';
import 'package:diving/Repository/CourseRepository.dart';
import 'package:diving/Models/Course.dart';
import 'package:diving/Repository/UserRepository.dart';
import 'package:diving/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../Controllers/CourseController.dart';
import '../../Models/User.dart';
import 'HomePage.dart';

class CoursesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CoursesPageState();
  }
  final User user;
  CoursesPage(this.user);
}

class _CoursesPageState extends State<CoursesPage> {
  static const engLanguage = "English";
  static const ukrLanguage = "Українська";
  var curLanguage = "Українська";

  var client = CourseRepository();
  final courseController = CourseController(CourseRepository());

  final userController = UserController(UserRepository());


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(0, 0, 0, 1.0),
            centerTitle: true,
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
            actions: [
              PopupMenuButton(
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                      onTap: () async{
                        await context.setLocale(Locale('uk'));
                        widget.user.languageId = 0;
                        await userController.updateUserData(widget.user);
                      },
                      value: ukrLanguage,
                      child: Text(
                        ukrLanguage,
                        style: TextStyle(color: Colors.white),
                      )),
                  PopupMenuItem(
                    onTap: () async{
                      await context.setLocale(Locale('en'));
                      widget.user.languageId = 1;
                      await userController.updateUserData(widget.user);
                    },
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
              ),
            ],
            title: const Text('ProDiver'),
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
                  FutureBuilder(
                      future: courseController.getCoursesList(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.data == null) {
                          return Text(LocaleKeys.loading.tr());
                        } else {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, i) {
                              final course = snapshot.data[i] as Course;
                              return Card(
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.pushAndRemoveUntil(context,
                                          MaterialPageRoute(builder: (BuildContext context) {
                                            return CourseInfoPage(widget.user, course);
                                          }), (route) => false);
                                    },
                                    child: ListTile(
                                          title: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                            child: Text(plural(LocaleKeys.course_name_, 0,namedArgs: {"courseName": course.courseName!})),
                                        ),
                                      ),
                                      Container(
                                          child: Text(plural(LocaleKeys.min_hours_under_water_, course.minHoursUnderWater!)),
                                      ),
                                      Expanded(
                                        child: Container(
                                            child: Text(plural(LocaleKeys.cost_, course.cost!)),
                                          alignment: Alignment.centerRight,
                                        ),
                                      ),
                                    ],
                                  )),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      }),
                ],
              ),
            ),
          )),
    );
  }
}
