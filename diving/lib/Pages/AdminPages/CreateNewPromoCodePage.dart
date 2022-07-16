import 'package:diving/Models/PromoCode.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../Controllers/PromoCodeController.dart';
import '../../Models/User.dart';
import '../../Repository/PromoCodeRepository.dart';
import '../../generated/locale_keys.g.dart';
import 'PromoCodesListPage.dart';


class CreateNewPromoCodePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CreateNewPromoCodePageState();
  }

  final User user;

  CreateNewPromoCodePage(this.user);
}

class _CreateNewPromoCodePageState extends State<CreateNewPromoCodePage> {
  static const engLanguage = "English";
  static const ukrLanguage = "Українська";

  bool wrongInput = false;

  final _promoCodeController = TextEditingController(text: "");
  final _discountController = TextEditingController(text: "");
  final _isActiveController = TextEditingController(text: "");

  bool isActive = false;
  var promoCodeController = PromoCodeController(PromoCodeRepository());

  PromoCode? createNewPromoCode() {
    List<String> data = [];
    data.add(_promoCodeController.text);
    data.add(_discountController.text);
    data.add(_isActiveController.text);

    for (int i = 0; i < 2; i++) {
      if (data[i].length < 1) {
        wrongInput = true;
      }
    }

    if (wrongInput == false && double.tryParse(_discountController.text) != null) {
      if(_isActiveController.text == 'true')
        isActive = true;
      PromoCode promoCode = new PromoCode(
        0,
        _promoCodeController.text,
        isActive,
        double.tryParse(_discountController.text),
      );
      return promoCode;
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
    inputInformationComponent("", _promoCodeController, LocaleKeys.promo_code.tr()),
    inputInformationComponent("", _discountController, LocaleKeys.discount.tr()),
    inputInformationComponent("", _isActiveController, LocaleKeys.is_active.tr()),
  ];

  @override
  Widget build(BuildContext context) {
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
                        return PromoCodesListPage(widget.user);
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
                    LocaleKeys.creating_new_promo_code.tr(),
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
                                    LocaleKeys.data_cant_be_empty_or_less_than_2_liters.tr()),
                              );
                            });
                      } else {
                        if (createNewPromoCode() == null) {
                          return showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(LocaleKeys.wrong_input_data.tr()),
                                );
                              });
                        } else {
                          await promoCodeController.postPromoCode(createNewPromoCode()!);
                          return showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(LocaleKeys.success.tr()),
                                );
                              });
                        }
                      }
                    },
                    child: Text(
                      LocaleKeys.create.tr(),
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
