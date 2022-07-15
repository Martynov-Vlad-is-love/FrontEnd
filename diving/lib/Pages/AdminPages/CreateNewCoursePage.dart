import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../Controllers/CourseController.dart';
import '../../Models/Course.dart';
import '../../Models/User.dart';
import '../../Repository/CourseRepository.dart';
import 'AdminCoursesPage.dart';


class CreateNewCoursePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CreateNewCoursePageState();
  }

  final User user;

  CreateNewCoursePage(this.user);
}

class _CreateNewCoursePageState extends State<CreateNewCoursePage> {
  static const engLanguage = "English";
  static const ukrLanguage = "Українська";

  bool wrongInput = false;

  final _courseNameController = TextEditingController(text: "");
  final _costController = TextEditingController(text: "");
  final _descriptionController = TextEditingController(text: "");
  final _minHoursUnderWaterController = TextEditingController(text: "");
  final _imageController = TextEditingController(text: "");

  String imagePath = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAQMAAADCCAMAAAB6zFdcAAAAh1BMVEX///8rKikAAAAoJyb29vbm5uYEAAA1NDMNCghKSUgiISARDw0gHx4lJCMbGhjt7e1xcHDHx8cWFRO7u7sJBgLe3t7r6+vQ0NCzs7N9fHyioqKYl5dgX19VVFOpqaj5+fk9PDyIiIcxMC9YV1dEQ0J0c3NnZmbNzc2lpaXCwsKCgYGOjo6YmJcn4GmtAAAEg0lEQVR4nO3c63aqOhQFYA2oQIAi4q7XVltrL/b9n+/I9vTscXbXwiBKusj8fjdjLKYhJCG01wMAAAAAAAAAAAAAAAAAAAAAAJDv7n7yuc1W63UYrp9X2fZz9jqwXVOL/PHyWasgT+MoOYmiOM31UO3ms6nt6lowWIRKp0mf5MW5iufvtmu8rVmouOv/k4NW83vbhd6Kv9T6TAD/itVmYrvam1gWqVEAvyX6qXspTOLcPIHf90QRdmt89FdDr14EZV9QW9t1X9E4j2onUEpHnekKS1W/E3x1hY6MCllwYQIldbBd/jU81xwM/xLMbV9Ac+saT0SSfrF9CU2tmkZwDEF4T3hpdiOcBKLHhEVxhQiOA+PM9oVc7l6duzrvuG6OouTcs1OJnSc8xpXXluRFkIT7LNuHXlBUTqOSke1ruVQWV3SAXK0epv7Xnz5OZ/si5yPLhU6bX/k7wdP9N/9bg9kmYFMQejeM2AuK9QPdZBJzXSdZt1v8dcw0F0Gxf2Rb7bmJtXptsfZreeK6gXqrarZk7iCJHeGd/UHP7JkumBAEjghrZuvwXAS93paeW8biHg0D5tfUn+fbhmR8Xnr7qq9rQa+VopVBWya/QtqOO/1b9oM7k8Yf5BMyNehCP4k/JCPIF0at6Y6QmPShH2RMTg48z7A53YuEDQif5HCQM9NDw+bK6Eb6MTJyFaj5+eH/0d2okDVDINcK8Ydp8wG596LHtyz56shpjvnD7Y4cFLWolw2+SiPv767gJcbt6QxyWRm8bbNdXBQ6P2bx361gvj9M3wuyMjjxp+OHQ7ZJT1kkNboyPSZqwSdUTlmE6pdxC3qmHUibLDdCz5FqhCgfs2jStutqE71mkrZeaITpBqnZgqsbdvS6W+Bm2sU+6L00T+y7pvoOzGasQ7fClntVrb6/mOqoF+7NTCpuW/lSK/bMhivdwN+xJ3cMdyLFm0bsGQS5BxDqea84z+vI3IB72Voamm7GylZ1mjUXfjrPTMVo2O/HAl+71zdNK05kRRvb5bVhUnWwPXlyYWbAnbo4RdB3IYJtZQSerBdsl5lXfd6Q9F2IIGOPr5XDoRNjQeXB9nhn+pJWsnlVL0idmBcsq87268x2eW2YVD0ROvV1I4s7v3eKwI1l0oj/AtxTss5bXOrAPxKixI1/ijHl74Q0dGFacLRil4p6b7u2lvDdoBuf95p44b5YUY7sIPd6j/RhXtnfMtY0YSbJDkXAHGR1ZWZ0Qs8NtDPD4dGUHA6iZ9t1tWlC9gOzLzy64kC9TpD2oUpD5JAo7PuEpnbEC4UktF1Vu6jZQerSQ+GIWizI+jyhMfKzN2Gf6jR1R2Xg2JBIZ2C7qnb9ojLIbVfVLqofeH3bVbWLzMCRo2dfyAw2tqtql6+Sb9w4cvOHPwq/c+INKwAAALAGNNtltclXQ4pTq2fm3ycFtutqEzJABiVkgAxKyAAZlJABMighA2RQQgbIoIQMkEEJGSCDEjJABiVkUO6pepSh7bra5KcjSmy7LgAAAAAAAAAAAAAAAAAAAAAAgMv9A2YGN4WHKoqEAAAAAElFTkSuQmCC";

  var courseController = CourseController(CourseRepository());

  Course? createNewCourse() {
    List<String> data = [];
    data.add(_courseNameController.text);
    data.add(_costController.text);
    data.add(_descriptionController.text);
    data.add(_minHoursUnderWaterController.text);
    data.add(_imageController.text);

    for (int i = 0; i < 4; i++) {
      if (data[i].length < 1) {
        wrongInput = true;
      }
    }

    if (wrongInput == false && double.tryParse(_costController.text) != null) {
      Course course = new Course(
        0,
        _courseNameController.text,
        double.tryParse(_costController.text),
        _descriptionController.text,
        int.parse(_minHoursUnderWaterController.text),
        _imageController.text,
      );
      return course;
    } else {
      return null;
    }
  }

  Widget inputInformationComponent(String text, TextEditingController input, String label) {
    return Container(
      height: 50,
      width: 300,
      margin: EdgeInsetsDirectional.fromSTEB(50, 40, 50, 0),
      padding: EdgeInsetsDirectional.fromSTEB(20, 2, 10, 5),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: text,
          border: InputBorder.none,
          filled: false,
          labelText: label,
          labelStyle: TextStyle(fontSize: 16, height: 50),
        ),
        controller: input,
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
    );
  }

  String language(int id) {
    if (id == 0) {
      return ukrLanguage;
    } else
      return engLanguage;
  }

  List<Widget> userInformationBar1() => [
        inputInformationComponent("", _courseNameController, "Course name"),
        inputInformationComponent("", _costController, "Course cost"),
      ];

  List<Widget> userInformationBar2() => [
        inputInformationComponent("", _descriptionController, "Description"),
        inputInformationComponent("", _minHoursUnderWaterController, "Minimal hours under water"),
      ];

  changeImage(String path) {
    if(path != ""){
      setState(() {
        imagePath = path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var curLanguage = language(widget.user.languageId!);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(0, 0, 0, 1.0),
          centerTitle: true,
          title: const Text('ProDiver Admin'),
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
                  return AdminCoursesInfoPage(widget.user);
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
          child: Column(
            children: [
              Container(
                margin: EdgeInsetsDirectional.fromSTEB(30, 55, 40, 0),
                child: Text(
                  "Creating new user",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 50),
                ),
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 200,
                    width: 200,
                    child: Image.network(imagePath, fit: BoxFit.cover,),

                  ),
                  Container(
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          width: 300,
                          margin: EdgeInsetsDirectional.fromSTEB(50, 40, 50, 0),
                          padding: EdgeInsetsDirectional.fromSTEB(20, 2, 10, 5),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "",
                              border: InputBorder.none,
                              filled: false,
                              labelText: "Image url",
                              labelStyle: TextStyle(fontSize: 16, height: 50),
                            ),
                            controller: _imageController,
                          ),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              color: Colors.redAccent,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black54.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 5,
                                  offset: Offset(
                                      0, 1), // changes position of shadow
                                ),
                              ]),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                          ),
                          child: Text(
                            "Set image",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          onPressed: () async {
                            changeImage(_imageController.text);
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: userInformationBar1(),
                    ),
                  ),
                  Container(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: userInformationBar2()),
                  ),
                ],
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
                    if (wrongInput == true) {
                      return showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                  "Data can't be empty or less than 2 liters"),
                            );
                          });
                    } else {
                      if (createNewCourse() == null) {
                        return showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Wrong input data"),
                              );
                            });
                      } else {
                        await courseController.postCourse(createNewCourse()!);
                        return showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Success"),
                              );
                            });
                      }
                    }
                  },
                  child: Text(
                    'Create',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
