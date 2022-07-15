import 'dart:io';
import 'package:diving/Controllers/UserCourseController.dart';
import 'package:diving/Repository/CourseRepository.dart';
import 'package:diving/Repository/UserCourseRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../Controllers/CourseController.dart';
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

  final pdfFile = pw.Document();

  Future savePdf() async {
    try {
      Directory directory =
      Directory("D:/Android_Studio_repos/FrontEnd/certificate.pdf");

      String documentPath = directory.path;

      File file = File("$documentPath");
      print(file.path.toString());

      file.writeAsBytesSync(List.from(await pdfFile.save()));
    } catch (ex) {
      print(ex);
    }
  }

  writeOnPdf() async {
    var data = await rootBundle.load("Montserrat-Italic-VariableFont_wght.ttf");
    var myFont = pw.Font.ttf(data);
    pdfFile.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return <pw.Widget>[
            pw.Header(
                level: 0,
                child:
                pw.Text("Test attempt", style: pw.TextStyle(font: myFont))),
            pw.Paragraph(
                text: "First time certificate",
                style: pw.TextStyle(font: myFont)),
            pw.Paragraph(
                text: "Second time certificate",
                style: pw.TextStyle(font: myFont)),
            pw.Header(
              level: 1,
              child: pw.Text("laalal", style: pw.TextStyle(font: myFont)),
            ),
            pw.Paragraph(
                text: "Third time certificate",
                style: pw.TextStyle(font: myFont)),
            pw.Paragraph(
                text: "Fourth time certificate",
                style: pw.TextStyle(font: myFont)),
          ];
        }));
  }

  final pdf = pw.Document();

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
                            fontWeight: pw.FontWeight.bold))
                  ])
              )
      ),
    );
    savePDF();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            ),
            IconButton(
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(),
                  );
                },
                icon: const Icon(Icons.search))
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
                        return Text('Loading...');
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
                                                title: Text(
                                                    "Do you already complete this course. Do you want to take certificate?"),
                                                contentPadding:
                                                const EdgeInsets.all(20.0),
                                                children: [
                                                  TextButton(
                                                      onPressed: () async {
                                                        await createPDF(
                                                            widget.user.name!,
                                                            widget
                                                                .user.surname!,
                                                            courseName);
                                                        // final pdfFile = await PdfApi.generatePdf(widget.user.name!, widget.user.surname!, courseName);
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: const Text("Yes")),
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: const Text("No"))
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
                                              child: Text(
                                                  'Course: $courseName'),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                                '${userCourse.completed}%'),
                                          ),
                                          Expanded(
                                            child: Container(
                                              child: Text(
                                                  "Total price ${userCourse
                                                      .totalPrice}"),
                                              alignment: Alignment.centerRight,
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              child: Text('Course bought'),
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
        ));
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = ['Trainee', 'Intermediate', 'Pro'];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var course in searchTerms) {
      if (course.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(course);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var course in searchTerms) {
      if (course.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(course);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result),
          );
        });
  }
}
