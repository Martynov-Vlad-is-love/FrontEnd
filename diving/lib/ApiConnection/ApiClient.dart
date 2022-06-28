import 'dart:convert';

import 'package:diving/Models/Course.dart';
import 'package:http/http.dart' as http;

class ApiClient{
  Future<List<Course>> getCourseData() async{
    var response = await http.get(Uri.https('localhost:44329', 'api/Course'));
    var jsonData = jsonDecode(response.body);
    print(response);
    List<Course> courses = [];

    for(var item in jsonData){
      Course course = Course(item["id"], item["courseName"], item["cost"], item["description"], item["minHoursUnderWater"], item["image"]);
      courses.add(course);
    }
    print(courses.length);
    return courses;
  }
}