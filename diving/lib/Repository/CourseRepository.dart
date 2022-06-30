import 'dart:convert';

import 'package:diving/Models/Course.dart';
import 'package:http/http.dart' as http;

class CourseRepository {
  Future<void> post(Course course) async{
    await http.post(Uri.https('localhost:44329', 'api/Course'), body: {
      'courseName': '${course.courseName}',
      'cost': '${course.cost}',
      'description': '${course.description}',
      'minHoursUnderWater': '${course.minHoursUnderWater}',
      'image': '${course.image}'
    });
  }

  Future<List<Course>> getCourseData() async {
    var response = await http.get(Uri.https('localhost:44329', 'api/Course'));

    var jsonData = jsonDecode(response.body);

    List<Course> courses = [];

    for (int i = 0; i < jsonData.length; i++) {
      courses.add(Course.fromJson(jsonData[i]));
    }

    return courses;
  }
}
