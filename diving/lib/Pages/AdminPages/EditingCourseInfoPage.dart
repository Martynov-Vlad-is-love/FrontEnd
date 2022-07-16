import 'package:diving/Controllers/UserController.dart';
import 'package:diving/Repository/UserRepository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Controllers/CourseController.dart';
import '../../Models/Course.dart';
import '../../Models/User.dart';
import '../../Repository/CourseRepository.dart';
import '../../generated/locale_keys.g.dart';
import 'AdminCoursesPage.dart';

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

  String imagePath = "";
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
    inputInformationComponent(widget.courseToEdit.courseName ?? "", _courseNameInputController, LocaleKeys.course_name.tr()),
    inputInformationComponent(widget.courseToEdit.description ?? "", _descriptionInputController, LocaleKeys.description.tr()),
  ];

  List<Widget> userInformationBar2() => [
    inputInformationComponent(widget.courseToEdit.cost.toString(), _costInputController, LocaleKeys.course_cost.tr()),
    inputInformationComponent(widget.courseToEdit.minHoursUnderWater.toString(), _minHoursUnderWaterInputController, LocaleKeys.minimal_hours_under_water.tr()),
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
          widget.courseToEdit.image = _imageInputController.text;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    imagePath = widget.courseToEdit.image!;
    var curLanguage = language(widget.user.languageId!);
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(0, 0, 0, 1.0),
            centerTitle: true,
            title: const Text('ProDiver Admin'),
            actions: [
              PopupMenuButton(
                itemBuilder: (BuildContext context) => [

                  PopupMenuItem(
                      onTap: () async{
                        await context.setLocale(Locale('uk'));
                      },
                      value: ukrLanguage,
                      child: Text(
                        ukrLanguage,
                        style: TextStyle(color: Colors.white),
                      )),
                  PopupMenuItem(
                    onTap: () async{
                      await context.setLocale(Locale('en'));
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
                    plural(LocaleKeys.editing_course_, widget.courseToEdit.id!),
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
                                labelText: LocaleKeys.image_url.tr(),
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
                              LocaleKeys.set_image.tr(),
                              style: TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            onPressed: () {
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
                                    LocaleKeys.data_cant_be_empty_or_less_than_2_liters.tr()),
                              );
                            });
                      }
                      else {
                        if (widget.courseToEdit.id == null) {
                          print(LocaleKeys.course_not_found.tr());
                        } else if (widget.courseToEdit.id != null) {
                          save();
                          await courseController.updateCourseData(widget.courseToEdit);
                          return showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                      LocaleKeys.success.tr()),
                                );
                              });
                        }
                      }
                    },
                    child: Text(
                      LocaleKeys.save.tr(),
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
