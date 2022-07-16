import 'package:diving/Models/PromoCode.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Controllers/PromoCodeController.dart';
import '../../Models/User.dart';
import '../../Repository/PromoCodeRepository.dart';
import '../../generated/locale_keys.g.dart';
import 'PromoCodesListPage.dart';


class EditingPromoCodeInfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EditingPromoCodeInfoPageState();
  }

  final User user;
  final PromoCode promoCodeToEdit;

  EditingPromoCodeInfoPage(this.user, this.promoCodeToEdit);

}

class _EditingPromoCodeInfoPageState extends State<EditingPromoCodeInfoPage> {
  static const engLanguage = "English";
  static const ukrLanguage = "Українська";

  final _discountInputController = TextEditingController(text: "");
  final _promoCodeInputController = TextEditingController(text: "");
  final _isActiveInputController = TextEditingController(text: "");

  double? discount = 0.0;

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
    inputInformationComponent(widget.promoCodeToEdit.promoCode ?? "", _promoCodeInputController, LocaleKeys.promo_code.tr()),
    inputInformationComponent(widget.promoCodeToEdit.discount.toString(), _discountInputController, LocaleKeys.discount.tr()),
    inputInformationComponent(widget.promoCodeToEdit.isActive.toString(), _isActiveInputController, LocaleKeys.is_active.tr()),
  ];

  void save() {

    if (_promoCodeInputController.text.length > 2)
      widget.promoCodeToEdit.promoCode = _promoCodeInputController.text;
    else if(_promoCodeInputController.text.isNotEmpty)
      wrongInput = true;

    if (_discountInputController.text.length > 0)
      discount = double.tryParse(_discountInputController.text);
      if(discount != null && discount! > 0)
        widget.promoCodeToEdit.discount = discount;
    else if(_promoCodeInputController.text.isNotEmpty)
      wrongInput = true;

    if (_isActiveInputController.text.length > 0)
      if(_isActiveInputController.text == "true")
      widget.promoCodeToEdit.isActive = true;
      else if(_isActiveInputController.text == "false")
        widget.promoCodeToEdit.isActive = false;
      else
        wrongInput = true;
    else if(_isActiveInputController.text.isNotEmpty)
      wrongInput = true;

  }

  var promoCodeController = PromoCodeController(PromoCodeRepository());

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
                    plural(LocaleKeys.editing_promo_code_, widget.promoCodeToEdit.id!),
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
                        if (widget.promoCodeToEdit.id == null) {
                          print(LocaleKeys.promo_code_not_found.tr());
                        } else if (widget.promoCodeToEdit.id != null) {
                          await promoCodeController.updatePromoCodeData(widget.promoCodeToEdit);
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
