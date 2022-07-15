import 'dart:convert';

import 'package:diving/Models/User.dart';
import 'package:diving/Models/UserCourse.dart';
import 'package:diving/Repository/Repository.dart';
import 'package:http/http.dart' as http;

class UserCourseRepository implements Repository {
  final authority = 'localhost:44329';
  final unencodedPath = 'api/User_Courses';

  String unencodedPathById(int id) {
    return '$unencodedPath/$id';
  }

  String unencodedPathByUserId(int id) {
    return '$unencodedPath/ByUser/$id';
  }

  @override
  Future<void> postData(userCourse) async {
    var response = await http.post(Uri.https(authority, unencodedPath, userCourse.toJson()));
    print("Status code ${response.statusCode}");
  }

  @override
  Future<List<UserCourse>> getAllData() async {
    List<UserCourse> userCourses = [];
    try{
      var response = await http.get(Uri.https(authority, unencodedPath));
      var jsonData = jsonDecode(response.body);

      for (int i = 0; i < jsonData.length; i++) {
        userCourses.add(UserCourse.fromJson(jsonData[i]));
      }
    }catch(ex){
      print(ex);
    }


    return userCourses;
  }
  
  Future<List<UserCourse>> getDataByUserId(int id) async {
    List<UserCourse> userCourses = [];
    try{
      var response = await http.get(Uri.https(authority, unencodedPathByUserId(id)));
      print(response.body);
      print(response.statusCode);
      var jsonData = jsonDecode(response.body);

      for (int i = 0; i < jsonData.length; i++) {
        userCourses.add(UserCourse.fromJson(jsonData[i]));
      }
      print(response.body);
    }catch(ex){
      print(ex);
    }
    return userCourses;

  }
  
  @override
  Future<void> deleteData(int id) async {
    await http.delete(Uri.https(authority, unencodedPathById(id)));
  }

  Future<void> deleteDataByUserId(int id) async {
    var response =
        await http.delete(Uri.https(authority, unencodedPathByUserId(id)));
    print(response.body);
  }

  @override
  Future<UserCourse> getDataById(int id) async{
    var response = await http.get(Uri.https(authority, unencodedPathById(id)));
    
    var jsonData = jsonDecode(response.body);

    UserCourse userCourse = UserCourse.fromJson(jsonData);
    
    return userCourse;
  }

  @override
  Future<void> updateData(userCourse) async{
    var jsonMap = userCourse.toJson();

    for (var item in jsonMap.keys) {
      print("$item: ${jsonMap[item]}, ${jsonMap[item].runtimeType}");
    }

    var _jsonEncoded = jsonEncode(jsonMap);

    var response = await http.put(
        Uri.https(authority, unencodedPathById(userCourse.id!)),
        body: _jsonEncoded,
        headers: {
          'Content-type': 'application/json',
          "Accept": "application/json"
        });
    print("Status code: ${response.body}");
  }
}
