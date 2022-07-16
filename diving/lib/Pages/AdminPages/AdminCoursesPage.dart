import 'package:diving/Controllers/UserController.dart';
import 'package:diving/Models/Course.dart';
import 'package:diving/Pages/AdminPages/CreateNewUserPage.dart';
import 'package:diving/Repository/UserCourseRepository.dart';
import 'package:diving/Repository/UserRepository.dart';
import 'package:diving/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Controllers/CourseController.dart';
import '../../Controllers/UserCourseController.dart';
import '../../Models/User.dart';
import '../../Repository/CourseRepository.dart';
import 'AdminHomePage.dart';
import 'CreateNewCoursePage.dart';
import 'EditingCourseInfoPage.dart';


class AdminCoursesInfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AdminCoursesInfoPageState();
  }
  final User user;
  AdminCoursesInfoPage(this.user);
}

class _AdminCoursesInfoPageState extends State<AdminCoursesInfoPage> {
  static const engLanguage = "English";
  static const ukrLanguage = "Українська";
  var curLanguage = "Українська";

  final idController = TextEditingController(text: "");
  final userCourseController = UserCourseController(UserCourseRepository());
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
                        return AdminHomePage(widget.user);
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
            title: const Text('ProDiver Admin'),
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
                    height: 500,
                    child: SingleChildScrollView(
                      child: FutureBuilder(
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
                                        onTap: () async{
                                          Navigator.pushAndRemoveUntil(context,
                                              MaterialPageRoute(builder: (BuildContext context) {
                                                return EditingCourseInfoPage(widget.user,course);
                                              }), (route) => false);
                                        },
                                        child: ListTile(
                                            title: Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    child: Text('${course.id}'),
                                                  ),
                                                ),
                                                Container(
                                                  child: Text('${course.courseName}'),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    child: Text('${course.cost.toString()}'),
                                                    alignment: Alignment.centerRight,
                                                  ),
                                                ),
                                              ],
                                            )
                                        ),

                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          }),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 180,
                    margin: EdgeInsetsDirectional.fromSTEB(100, 35, 100, 0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                      ),
                      onPressed: () async{
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                              return CreateNewCoursePage(widget.user);
                            }), (route) => false);
                      },
                      child: Text(LocaleKeys.create_new_course.tr(),style: TextStyle(color: Colors.white, fontSize: 15),),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 180,
                    margin: EdgeInsetsDirectional.fromSTEB(100, 35, 100, 0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                      ),
                      onPressed: () async{
                        showDialog(context: context,
                            builder: (context) => SimpleDialog(
                              title: Text(LocaleKeys.do_you_really_want_to_delete_this_course.tr()),
                              contentPadding: const EdgeInsets.all(20.0),
                              children: [
                                TextFormField(controller: idController),
                                TextButton(onPressed: () async{
                                  await courseController.deleteCourse(int.parse(idController.text));
                                  Navigator.of(context).pop();
                                }, child: Text(LocaleKeys.delete.tr())),
                                TextButton(onPressed: (){
                                  Navigator.of(context).pop();
                                }, child: Text(LocaleKeys.cancel.tr()))
                              ],
                            )
                        );
                      },
                      child: Text(LocaleKeys.delete_course_by_id.tr(),style: TextStyle(color: Colors.white, fontSize: 15),),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
