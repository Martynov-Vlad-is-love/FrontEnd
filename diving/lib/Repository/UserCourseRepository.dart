import 'dart:convert';

import 'package:diving/Models/User.dart';
import 'package:diving/Models/UserCourse.dart';
import 'package:http/http.dart' as http;

class UserCourseRepository{

  final authority = 'localhost:44329';
  final unencodedPath = 'api/User_Courses';

  Future<void> postUserCourse(User user) async{
    await http.post(Uri.https(authority, unencodedPath), body: user.toJson());
  }

  Future<List<UserCourse>> getCourseData() async{
    var response = await http.get(Uri.https(authority, unencodedPath));

    var jsonData = jsonDecode(response.body);

    List<UserCourse> userCourses = [];
    for (int i = 0; i < jsonData.length; i++) {
      userCourses.add(UserCourse.fromJson(jsonData[i]));
    }

    return userCourses;
  }
}