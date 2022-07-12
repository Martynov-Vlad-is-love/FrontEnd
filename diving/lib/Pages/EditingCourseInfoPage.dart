import 'package:diving/Controllers/UserController.dart';
import 'package:diving/Repository/UserRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Controllers/CourseController.dart';
import '../Models/Course.dart';
import '../Models/User.dart';
import '../Repository/CourseRepository.dart';
import 'AdminCoursesPage.dart';
import 'UsersInfoPage.dart';

class EditingCourseInfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EditingCourseInfoPageState();
  }

  final User user;
  final Course courseToEdit;

  EditingCourseInfoPage(this.user, this.courseToEdit);

}

class _EditingCourseInfoPageState extends State<EditingCourseInfoPage> {
  static const engLanguage = "English";
  static const ukrLanguage = "Українська";

  final _courseNameInputController = TextEditingController(text: "");
  final _costInputController = TextEditingController(text: "");
  final _descriptionInputController = TextEditingController(text: "");
  final _minHoursUnderWaterInputController = TextEditingController(text: "");
  final _imageInputController = TextEditingController(text: "");

  String imagePath = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAQMAAADCCAMAAAB6zFdcAAAAh1BMVEX///8rKikAAAAoJyb29vbm5uYEAAA1NDMNCghKSUgiISARDw0gHx4lJCMbGhjt7e1xcHDHx8cWFRO7u7sJBgLe3t7r6+vQ0NCzs7N9fHyioqKYl5dgX19VVFOpqaj5+fk9PDyIiIcxMC9YV1dEQ0J0c3NnZmbNzc2lpaXCwsKCgYGOjo6YmJcn4GmtAAAEg0lEQVR4nO3c63aqOhQFYA2oQIAi4q7XVltrL/b9n+/I9vTscXbXwiBKusj8fjdjLKYhJCG01wMAAAAAAAAAAAAAAAAAAAAAAJDv7n7yuc1W63UYrp9X2fZz9jqwXVOL/PHyWasgT+MoOYmiOM31UO3ms6nt6lowWIRKp0mf5MW5iufvtmu8rVmouOv/k4NW83vbhd6Kv9T6TAD/itVmYrvam1gWqVEAvyX6qXspTOLcPIHf90QRdmt89FdDr14EZV9QW9t1X9E4j2onUEpHnekKS1W/E3x1hY6MCllwYQIldbBd/jU81xwM/xLMbV9Ac+saT0SSfrF9CU2tmkZwDEF4T3hpdiOcBKLHhEVxhQiOA+PM9oVc7l6duzrvuG6OouTcs1OJnSc8xpXXluRFkIT7LNuHXlBUTqOSke1ruVQWV3SAXK0epv7Xnz5OZ/si5yPLhU6bX/k7wdP9N/9bg9kmYFMQejeM2AuK9QPdZBJzXSdZt1v8dcw0F0Gxf2Rb7bmJtXptsfZreeK6gXqrarZk7iCJHeGd/UHP7JkumBAEjghrZuvwXAS93paeW8biHg0D5tfUn+fbhmR8Xnr7qq9rQa+VopVBWya/QtqOO/1b9oM7k8Yf5BMyNehCP4k/JCPIF0at6Y6QmPShH2RMTg48z7A53YuEDQif5HCQM9NDw+bK6Eb6MTJyFaj5+eH/0d2okDVDINcK8Ydp8wG596LHtyz56shpjvnD7Y4cFLWolw2+SiPv767gJcbt6QxyWRm8bbNdXBQ6P2bx361gvj9M3wuyMjjxp+OHQ7ZJT1kkNboyPSZqwSdUTlmE6pdxC3qmHUibLDdCz5FqhCgfs2jStutqE71mkrZeaITpBqnZgqsbdvS6W+Bm2sU+6L00T+y7pvoOzGasQ7fClntVrb6/mOqoF+7NTCpuW/lSK/bMhivdwN+xJ3cMdyLFm0bsGQS5BxDqea84z+vI3IB72Voamm7GylZ1mjUXfjrPTMVo2O/HAl+71zdNK05kRRvb5bVhUnWwPXlyYWbAnbo4RdB3IYJtZQSerBdsl5lXfd6Q9F2IIGOPr5XDoRNjQeXB9nhn+pJWsnlVL0idmBcsq87268x2eW2YVD0ROvV1I4s7v3eKwI1l0oj/AtxTss5bXOrAPxKixI1/ijHl74Q0dGFacLRil4p6b7u2lvDdoBuf95p44b5YUY7sIPd6j/RhXtnfMtY0YSbJDkXAHGR1ZWZ0Qs8NtDPD4dGUHA6iZ9t1tWlC9gOzLzy64kC9TpD2oUpD5JAo7PuEpnbEC4UktF1Vu6jZQerSQ+GIWizI+jyhMfKzN2Gf6jR1R2Xg2JBIZ2C7qnb9ojLIbVfVLqofeH3bVbWLzMCRo2dfyAw2tqtql6+Sb9w4cvOHPwq/c+INKwAAALAGNNtltclXQ4pTq2fm3ycFtutqEzJABiVkgAxKyAAZlJABMighA2RQQgbIoIQMkEEJGSCDEjJABiVkUO6pepSh7bra5KcjSmy7LgAAAAAAAAAAAAAAAAAAAAAAgMv9A2YGN4WHKoqEAAAAAElFTkSuQmCC";

  bool wrongInput = false;

  Widget inputInformationComponent(
      String text, TextEditingController input, String label) {
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
    inputInformationComponent(widget.courseToEdit.courseName ?? "", _courseNameInputController, "Course name"),
    inputInformationComponent(widget.courseToEdit.description ?? "", _descriptionInputController, "Description"),
  ];

  List<Widget> userInformationBar2() => [
    inputInformationComponent(widget.courseToEdit.cost.toString(), _costInputController, "Course Cost"),
    inputInformationComponent(widget.courseToEdit.minHoursUnderWater.toString(), _minHoursUnderWaterInputController, "Minimal hours under water"),
  ];

  void save() {
    if (_courseNameInputController.text.length > 2)
      widget.courseToEdit.courseName = _courseNameInputController.text;
    else if(_courseNameInputController.text.isNotEmpty)
      wrongInput = true;

    if (_descriptionInputController.text.length > 2)
      widget.courseToEdit.description = _descriptionInputController.text;
    else if(_descriptionInputController.text.isNotEmpty)
      wrongInput = true;

    if (_costInputController.text.length > 0 && double.tryParse(_costInputController.text) != null && _costInputController.text != "")
      widget.courseToEdit.cost = double.tryParse(_costInputController.text);
    else if(_costInputController.text.isNotEmpty)
      wrongInput = true;

    if (_minHoursUnderWaterInputController.text.length > 0 && int.tryParse(_minHoursUnderWaterInputController.text) != null && _minHoursUnderWaterInputController.text != "")
      widget.courseToEdit.minHoursUnderWater = int.tryParse(_minHoursUnderWaterInputController.text);
    else if(_minHoursUnderWaterInputController.text.isNotEmpty)
      wrongInput = true;

    if (_imageInputController.text.length > 0)
      widget.courseToEdit.image = _imageInputController.text;
  }

  var courseController = CourseController(CourseRepository());

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
                  "Editing course ${widget.courseToEdit.id}",
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
                    child: Image.network(widget.courseToEdit.image!, fit: BoxFit.cover,),

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
                            controller: _imageInputController,
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
                            changeImage(_imageInputController.text);
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
                    save();
                    if (wrongInput == true) {
                      return showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                  "Data can't be empty or less than 2 liters"),
                            );
                          });
                    }
                    else {
                      if (widget.courseToEdit.id == null) {
                        print("Course not found");
                      } else if (widget.courseToEdit.id != null) {
                        save();
                        await courseController.updateCourseData(widget.courseToEdit);
                        return showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                    "Success"),
                              );
                            });
                      }
                    }
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
