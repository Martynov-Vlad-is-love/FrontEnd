import 'package:diving/Controllers/UserController.dart';
import 'package:diving/Repository/UserRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/User.dart';
import 'UsersInfoPage.dart';

class EditingUserInfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EditingUserInfoPageState();
  }

  final User user;
  final User userToEdit;

  EditingUserInfoPage(this.user, this.userToEdit);

}

class _EditingUserInfoPageState extends State<EditingUserInfoPage> {
  static const engLanguage = "English";
  static const ukrLanguage = "Українська";

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

  bool wrongInput = false;
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
    inputInformationComponent(widget.userToEdit.login ?? "", _loginInput, "Login"),
    inputInformationComponent(widget.userToEdit.password ?? "", _passwordInput, "Password"),
    inputInformationComponent(widget.userToEdit.maxDepth.toString(), _maxDepthInput, "Max depth"),
    inputInformationComponent(widget.userToEdit.phoneNumber ?? "", _phoneNumberInput, "Phone number"),
    inputInformationComponent(widget.userToEdit.roleId.toString(), _roleIdInput, "Role Id (0 = User| 2 = Admin)"),

  ];

  List<Widget> userInformationBar2() => [
    inputInformationComponent(widget.userToEdit.name ?? "", _nameInput, "Name"),
    inputInformationComponent(widget.userToEdit.surname ?? "", _surnameController, "Surname"),
    inputInformationComponent(widget.userToEdit.age.toString(), _ageInput, "Age"),
    inputInformationComponent(widget.userToEdit.disease ?? "", _diseaseInput, "Disease"),
    inputInformationComponent(widget.userToEdit.hoursUnderWater.toString(), _hoursUnderWaterInput, "Hours under water"),
  ];

  void save() {
    if (_nameInput.text.length >= 2)
      widget.userToEdit.name = _nameInput.text;
    else if(_nameInput.text.isNotEmpty)
      wrongInput = true;

    if (_surnameController.text.length > 2)
      widget.userToEdit.surname = _surnameController.text;
    else if(_surnameController.text.isNotEmpty)
      wrongInput = true;

    if (_ageInput.text.length > 0 && int.tryParse(_ageInput.text) != null && int.tryParse(_ageInput.text)! > 7)
      widget.userToEdit.age = int.tryParse(_ageInput.text);
    else if(_ageInput.text.isNotEmpty)
      wrongInput = true;

    if ( _phoneNumberInput.text.length > 2)
      widget.userToEdit.phoneNumber = _phoneNumberInput.text;
    else if(_phoneNumberInput.text.isNotEmpty)
      wrongInput = true;

    if (_loginInput.text.length > 2)
      widget.userToEdit.login = _loginInput.text;
    else if(_loginInput.text.isNotEmpty)
      wrongInput = true;

    if (_diseaseInput.text.length > 2)
      widget.userToEdit.disease = _diseaseInput.text;
    else if(_diseaseInput.text.isNotEmpty)
      wrongInput = true;

    if(_passwordInput.text.isNotEmpty){
      if (_passwordInput.text.length > 3){
        widget.userToEdit.password = _passwordInput.text;
      }
      else{
        checkPassword = false;
      }
    }

    if (_hoursUnderWaterInput.text.length > 0 && int.tryParse(_hoursUnderWaterInput.text) != null)
      widget.userToEdit.hoursUnderWater = double.tryParse(_hoursUnderWaterInput.text);
    else if(_hoursUnderWaterInput.text.isNotEmpty)
      wrongInput = true;

    if (_roleIdInput.text.length > 0 && int.tryParse(_roleIdInput.text) != null)
      widget.userToEdit.roleId = int.tryParse(_roleIdInput.text);
    else if(_roleIdInput.text.isNotEmpty)
      wrongInput = true;

    if (_maxDepthInput.text.length > 0 && double.tryParse(_maxDepthInput.text) != null)
    widget.userToEdit.maxDepth = double.tryParse(_maxDepthInput.text);
    else if(_maxDepthInput.text.isNotEmpty)
    wrongInput = true;

  }

  var userController = UserController(UserRepository());

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
                  "Editing user ${widget.userToEdit.id}",
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
                    }else if(!checkPassword){
                      return showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                  "Passwords should consist more than 3 symbols"),
                            );
                          });
                    }
                    else {
                      if (widget.userToEdit.id == null) {
                        print("User not found");
                      } else if (widget.userToEdit.id != null) {
                        await userController.updateUserData(widget.userToEdit);
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
