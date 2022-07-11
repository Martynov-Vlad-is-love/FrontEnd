import 'dart:convert';

import 'package:diving/Models/User.dart';
import 'package:diving/Models/UserCourse.dart';
import 'package:diving/Repository/Repository.dart';
import 'package:http/http.dart' as http;

class UserCourseRepository implements Repository{

  final authority = 'localhost:44329';
  final unencodedPath = 'api/User_Courses';

  String unencodedPathById(int id) {
    return '$unencodedPath/$id';
  }
  String unencodedPathByUserId(int id) {
    return '$unencodedPath/ByUser/$id';
  }

  @override
  Future<void> postData(userCourse) async{
    var response = await http.post(Uri.https(authority, unencodedPath), body: userCourse.toJson());
    print("Status code ${response.statusCode}");
  }

  @override
  Future<List<UserCourse>> getAllData() async{
    var response = await http.get(Uri.https(authority, unencodedPath));

    var jsonData = jsonDecode(response.body);

    List<UserCourse> userCourses = [];
    for (int i = 0; i < jsonData.length; i++) {
      userCourses.add(UserCourse.fromJson(jsonData[i]));
    }

    return userCourses;
  }

  @override
  Future<void> deleteData(int id) async{
    await http.delete(Uri.https(authority, unencodedPathById(id)));
  }

  Future<void> deleteDataByUserId(int id) async{
    var response = await http.delete(Uri.https(authority, unencodedPathByUserId(id)));
    print(response.body);
  }

  @override
  Future<List<UserCourse>> getDataById(int id) {
    // TODO: implement getDataById
    throw UnimplementedError();
  }

  @override
  Future<void> updateData(type) {
    // TODO: implement updateData
    throw UnimplementedError();
  }
}