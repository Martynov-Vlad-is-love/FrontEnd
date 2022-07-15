import 'package:diving/Controllers/UserController.dart';
import 'package:diving/Repository/UserRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../Models/User.dart';
import 'UsersInfoPage.dart';

class CreateNewUserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CreateNewUserPageState();
  }

  final User user;


  CreateNewUserPage(this.user);
}

class _CreateNewUserPageState extends State<CreateNewUserPage> {
  static const engLanguage = "English";
  static const ukrLanguage = "Українська";

  bool wrongInput = false;

  final _roleIdInput = TextEditingController(text: "");
  final _nameInput = TextEditingController(text: "");
  final _diseaseInput = TextEditingController(text: "");
  final _surnameController = TextEditingController(text: "");
  final _phoneNumberInput = TextEditingController(text: "");
  final _ageInput = TextEditingController(text: "");
  final _passwordInput = TextEditingController(text: "");
  final _loginInput = TextEditingController(text: "");
  final _maxDepthInput = TextEditingController(text: "");
  final _hoursUnderWaterInput = TextEditingController(text: "");

  var userController = UserController(UserRepository());

  User? register() {
    List<String> data = [];
    data.add(_nameInput.text);
    data.add(_surnameController.text);
    data.add(_loginInput.text);
    data.add(_passwordInput.text);
    data.add(_ageInput.text);
    data.add(_phoneNumberInput.text);
    data.add(_maxDepthInput.text);
    data.add(_hoursUnderWaterInput.text);
    data.add(_diseaseInput.text);
    data.add(_roleIdInput.text);
    for (int i = 0; i < 9; i++) {
      if (data[i].length < 1) {
        wrongInput = true;
      }
    }

    if (wrongInput == false) {
    User user = new User(
          0,
          _loginInput.text,
          _passwordInput.text,
          _nameInput.text,
          _surnameController.text,
          int.parse(_ageInput.text),
          double.parse(_maxDepthInput.text),
          double.parse(_hoursUnderWaterInput.text),
          DateFormat("yyyy-MM-ddTHH:mm:ss.mmm").format(DateTime.now()),
          _diseaseInput.text,
          _phoneNumberInput.text,
          int.parse(_roleIdInput.text),
          0);
      return user;
    } else {
      return null;
    }
  }

  bool checkPassword = true;

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
        inputInformationComponent("", _loginInput, "Login"),
        inputInformationComponent("", _passwordInput, "Password"),
        inputInformationComponent("", _maxDepthInput, "Max depth"),
        inputInformationComponent("", _phoneNumberInput, "Phone number"),
        inputInformationComponent("", _roleIdInput, "Role Id (0 = User| 2 = Admin)"),
      ];

  List<Widget> userInformationBar2() => [
        inputInformationComponent("", _nameInput, "Name"),
        inputInformationComponent("", _surnameController, "Surname"),
        inputInformationComponent("", _ageInput, "Age"),
        inputInformationComponent("", _diseaseInput, "Disease"),
        inputInformationComponent("", _hoursUnderWaterInput, "Hours under water"),
      ];

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
                  return UsersInfoPage(widget.user);
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
                    } else if (!checkPassword) {
                      return showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                  "Passwords should consist more than 3 symbols"),
                            );
                          });
                    } else {
                      if (register() == null) {
                        return showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                    "Passwords should consist more than 3 symbols"),
                              );
                            });
                      } else {
                        await userController.postUserData(register()!);
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
