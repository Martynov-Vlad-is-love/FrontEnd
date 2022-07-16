import 'package:diving/Pages/LoginScreen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:diving/Pages/RegistrationScreen.dart';

import 'generated/codegen_loader.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en'), Locale('uk')],
        path: 'assets/translations',
        fallbackLocale: Locale('uk'),
        assetLoader: CodegenLoader(),
        child: MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    try{
      return MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          title: 'ProDiving',
          // color: Colors.red[300];
          home: LoginScreen());
    } catch(ex){
      return Container();
    }
  }
}
