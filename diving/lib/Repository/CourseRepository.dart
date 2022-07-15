import 'dart:convert';

import 'package:diving/Models/Course.dart';
import 'package:http/http.dart' as http;

import 'Repository.dart';

class CourseRepository implements Repository{
  final authority = 'localhost:44329';
  final unencodedPath = 'api/Course';

  String unencodedPathById(int id) {
    return '$unencodedPath/$id';
  }

  @override
  Future<void> postData(course) async{
    var jsonMap = course.toJson();

    for (var item in jsonMap.keys) {
      print("$item: ${jsonMap[item]}, ${jsonMap[item].runtimeType}");
    }

    var response = await http.post(Uri.https(authority, unencodedPath, jsonMap));

    print(response.body);

  }

  @override
  Future<List<Course>> getAllData() async {
    var response = await http.get(Uri.https(authority, unencodedPath));

    var jsonData = jsonDecode(response.body);

    List<Course> courses = [];

    for (int i = 0; i < jsonData.length; i++) {
      courses.add(Course.fromJson(jsonData[i]));
    }

    return courses;
  }

  @override
  Future<void> deleteData(int id) async{
  await http.delete(Uri.https(authority, unencodedPathById(id)));
  }

  @override
  Future<List<Course>> getDataById(int id) async{
    // TODO: implement getDataById
    throw UnimplementedError();
  }


  @override
  Future<void> updateData(course) async{
    var jsonMap = course.toJson();

    var response = await http.put(Uri.https('localhost:44329', unencodedPathById(course.id)),
        body: jsonEncode(jsonMap),
        headers: {
          'Content-type': 'application/json',
          "Accept": "application/json"
        }
    );
    print(response.body);
  }
}
