import 'dart:convert';

import 'package:diving/Models/Course.dart';
import 'package:http/http.dart' as http;

import 'Repository.dart';

class CourseRepository implements Repository{

  @override
  Future<void> postData(course) async{
    await http.post(Uri.https('localhost:44329', 'api/Course'), body: {
      'courseName': '${course.courseName}',
      'cost': '${course.cost}',
      'description': '${course.description}',
      'minHoursUnderWater': '${course.minHoursUnderWater}',
      'image': '${course.image}'
    });
  }

  @override
  Future<List<Course>> getAllData() async {
    var response = await http.get(Uri.https('localhost:44329', 'api/Course'));

    var jsonData = jsonDecode(response.body);

    List<Course> courses = [];

    for (int i = 0; i < jsonData.length; i++) {
      courses.add(Course.fromJson(jsonData[i]));
    }

    return courses;
  }

  @override
  Future<void> deleteData(int id) {
    // TODO: implement deleteData
    throw UnimplementedError();
  }

  @override
  Future<List<Course>> getDataById(int id) {
    // TODO: implement getDataById
    throw UnimplementedError();
  }


  @override
  Future<void> updateData(type) {
    // TODO: implement updateData
    throw UnimplementedError();
  }
}
