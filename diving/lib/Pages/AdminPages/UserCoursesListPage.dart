import 'package:diving/Controllers/UserController.dart';
import 'package:diving/Repository/UserCourseRepository.dart';
import 'package:diving/Repository/UserRepository.dart';
import 'package:diving/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../Controllers/UserCourseController.dart';
import '../../Models/User.dart';
import '../../Models/UserCourse.dart';
import 'AdminHomePage.dart';
import 'CreateNewUserCoursePage.dart';
import 'EditingUserCoursesInfoPage.dart';


class UserCoursesListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UserCoursesListPageState();
  }

  final User user;

  UserCoursesListPage(this.user);
}

class _UserCoursesListPageState extends State<UserCoursesListPage> {
  static const engLanguage = "English";
  static const ukrLanguage = "Українська";
  var curLanguage = "Українська";

  final idController = TextEditingController(text: "");
  final userCourseController = UserCourseController(UserCourseRepository());

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
                          future: userCourseController.getUserCoursesList(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.data == null) {
                              return Text(LocaleKeys.loading.tr());
                            } else {
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, i) {
                                  final userCourse = snapshot.data[i] as UserCourse;
                                  return Card(
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pushAndRemoveUntil(context,
                                              MaterialPageRoute(builder:
                                                  (BuildContext context) {
                                            return EditingUserCoursesInfoPage(
                                                widget.user, userCourse);
                                          }), (route) => false);
                                        },
                                        child: ListTile(
                                            title: Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                child:
                                                    Text(plural(LocaleKeys.id_, userCourse.id!)),
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                  plural(LocaleKeys.course_id, userCourse.courseId!)),
                                            ),
                                            Expanded(
                                              child: Container(
                                                child: Text(
                                                    plural(LocaleKeys.user_id_, userCourse.userId!)),
                                                alignment: Alignment.centerRight,
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                alignment: Alignment.centerRight,
                                                child: Text(
                                                    plural(LocaleKeys.total_price_, userCourse.totalPrice!)),
                                              ),
                                            )
                                          ],
                                        )),
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
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                      ),
                      onPressed: () async {
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return CreateNewUserCoursePage(widget.user);
                        }), (route) => false);
                      },
                      child: Text(
                        LocaleKeys.create_new_promo_code.tr(),
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 180,
                    margin: EdgeInsetsDirectional.fromSTEB(100, 35, 100, 0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                      ),
                      onPressed: () async {
                        showDialog(
                            context: context,
                            builder: (context) => SimpleDialog(
                                  title: Text(
                                      LocaleKeys.do_you_really_want_to_delete_this_promo_code.tr()),
                                  contentPadding: const EdgeInsets.all(20.0),
                                  children: [
                                    TextFormField(controller: idController),
                                    TextButton(
                                        onPressed: () async {
                                          await userCourseController
                                              .deleteUserCourse(
                                                  int.parse(idController.text));
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(LocaleKeys.delete.tr())),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(LocaleKeys.cancel.tr()))
                                  ],
                                ));
                      },
                      child: Text(
                        LocaleKeys.delete_record_by_id.tr(),
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}


