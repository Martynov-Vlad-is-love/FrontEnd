import 'dart:io';
import 'package:diving/Controllers/UserCourseController.dart';
import 'package:diving/Repository/CourseRepository.dart';
import 'package:diving/Repository/UserCourseRepository.dart';
import 'package:diving/Repository/UserRepository.dart';
import 'package:diving/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../Controllers/CourseController.dart';
import '../../Controllers/UserController.dart';
import '../../Models/User.dart';
import '../../Models/UserCourse.dart';
import 'HomePage.dart';

class OwnCoursesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OwnCoursesPageState();
  }

  final User user;

  OwnCoursesPage(this.user);
}

class _OwnCoursesPageState extends State<OwnCoursesPage> {
  static const engLanguage = "English";
  static const ukrLanguage = "Українська";
  var curLanguage = "Українська";

  final courseController = CourseController(CourseRepository());
  final userCourseController = UserCourseController(UserCourseRepository());

  final pdf = pw.Document();

  final userController = UserController(UserRepository());

  Future<void> savePDF() async {
    Uint8List pdfInBytes = await pdf.save();
    final blob = html.Blob([pdfInBytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = 'Certificate.pdf';
    html.document.body!.children.add(anchor);
    anchor.click();
  }

  Future<void> createPDF(String name, String surname, String courseName) async {
    DateTime today = DateTime.now();
    var data =
    await rootBundle.load("fonts/Montserrat-Italic-VariableFont_wght.ttf");
    var myFont = pw.Font.ttf(data);
    pdf.addPage(
      pw.Page(
          build: (context) =>
              pw.Center(
                  child: pw.Column(children: [
                    pw.Text(
                        "$surname $name successfully completed $courseName course",
                        style: pw.TextStyle(
                            font: myFont,
                            fontSize: 40,
                            fontWeight: pw.FontWeight.bold)),
                    pw.Text("Date of printing certificate: $today",
                        style: pw.TextStyle(
                            font: myFont,
                            fontSize: 40,
                            fontWeight: pw.FontWeight.bold)),
                    pw.Text("Hours under water: ${widget.user.hoursUnderWater}",
                        style: pw.TextStyle(
                            font: myFont,
                            fontSize: 40,
                            fontWeight: pw.FontWeight.bold)),
                    pw.Text("Max depth: ${widget.user.maxDepth}",
                        style: pw.TextStyle(
                            font: myFont,
                            fontSize: 40,
                            fontWeight: pw.FontWeight.bold))
                  ])
              )
      ),
    );
    savePDF();
  }

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
                itemBuilder: (BuildContext context) =>
                [
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
                      future: userCourseController
                          .getUserCourseDataByUserId(widget.user.id!),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.data == null) {
                          return Text(LocaleKeys.loading.tr());
                        } else {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, i) {
                              final userCourse = snapshot.data[i] as UserCourse;
                              String courseName = "";
                              if (userCourse.courseId == 2) {
                                courseName = "Trainee";
                              } else if (userCourse.courseId == 3) {
                                courseName = "Intermediate";
                              } else if (userCourse.courseId == 4) {
                                courseName = "Pro";
                              }

                              return Card(
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () async {
                                      if (userCourse.completed! >= 100) {
                                        showDialog(
                                            context: context,
                                            builder: (context) =>
                                                SimpleDialog(
                                                  title: Text(LocaleKeys.you_already_complete_this_course_do_you_want_to_take_certificate.tr()),
                                                  contentPadding:
                                                  const EdgeInsets.all(20.0),
                                                  children: [
                                                    TextButton(
                                                        onPressed: () async {
                                                          await createPDF(
                                                              widget.user.name!,
                                                              widget.user.surname!,
                                                              courseName);
                                                          Navigator.of(context).pop();
                                                        },
                                                        child: Text(LocaleKeys.yes.tr())),
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text(LocaleKeys.no.tr()))
                                                  ],
                                                ));
                                      } else {
                                        userCourse.completed =
                                        (userCourse.completed! + 10);
                                        await userCourseController
                                            .updateUserCourseData(userCourse);
                                      }
                                    },
                                    child: ListTile(
                                        title: Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                child: Text(plural(LocaleKeys.course_name_, 0, namedArgs: {"courseName": courseName})),
                                              ),
                                            ),
                                            Container(
                                              child: Text(plural(LocaleKeys.completed_, userCourse.completed!)),
                                            ),
                                            Expanded(
                                              child: Container(
                                                child: Text(plural(LocaleKeys.total_price_, userCourse.totalPrice!)),
                                                alignment: Alignment.centerRight,
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                child: Text(LocaleKeys.course_bought.tr()),
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
