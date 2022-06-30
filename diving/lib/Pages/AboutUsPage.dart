import 'package:diving/Repository/CourseRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Models/Course.dart';


class AboutUsPage extends StatefulWidget{
  @override
  _AboutUsPage createState() => _AboutUsPage();

}

class _AboutUsPage extends State<AboutUsPage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ProDiver'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: () {
              var apiClient = CourseRepository();

            },
            child: Text('press'),

            ),
          ],
        ),
      ),
    );
  }


}