import 'package:diving/Repository/CourseRepository.dart';
import 'package:diving/Models/Course.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'HomePage.dart';
import 'RegistrationScreen.dart';

class CoursesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CoursesPageState();
  }
}

class _CoursesPageState extends State<CoursesPage> {
  static const engLanguage = "English";
  static const ukrLanguage = "Українська";
  var curLanguage = "Українська";
  var client = CourseRepository();

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
                  return HomePage();
                }), (route) => false);
              },
              icon: const Icon(Icons.arrow_back),
            );
          }),
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
                    future: client.getCourseData(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.data == null) {
                        return Text('Loading...');
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
                                    print('Ok');
                                  },
                                  child: ListTile(
                                        title: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                          child: Text('${course.courseName}'),
                                      ),
                                    ),
                                    Container(
                                        child: Text('${course.minHoursUnderWater.toString()}'),
                                    ),
                                    Expanded(
                                      child: Container(
                                          child: Text('${course.cost.toString()}'),
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
  List<String> searchTerms = [
    'Trainee',
    'Intermediate',
    'Pro'
  ];

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
