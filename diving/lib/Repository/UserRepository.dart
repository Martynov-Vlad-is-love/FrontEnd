import 'dart:convert';

import 'package:diving/Models/User.dart';
import 'package:http/http.dart' as http;

class UserRepository {

  final authority = 'localhost:44329';
  final unencodedPath = 'api/Users/';

  Future<void> postUserData(User user) async {
    try {
      await http.post(Uri.https(authority, unencodedPath), body: user.toJson());
    } catch (ex) {
      print(ex);
    }
  }

  Future<List<User>> getUserData() async {
    List<User> users = [];
    try {
      var response = await http.get(Uri.https(authority, unencodedPath));
      var jsonData = jsonDecode(response.body);

      for (int i = 0; i < jsonData.length; i++) {
        users.add(User.fromJson(jsonData[i]));
      }
    } catch (ex) {
      print(ex);
    }
    return users;
  }

  Future<void> updateUserData(User user) async {
    var jsonMap = user.toJson();
    Map<String, dynamic> userId = {'Id': user.id};
    await http.put(Uri.https(authority, unencodedPath, userId), body: jsonMap);
  }

  Future<void> deleteUser(int id) async {
    Map<String, dynamic> userId = {'Id': id};
    await http.delete(Uri.https(authority, unencodedPath, userId));
  }

  Future<User?> authentication(String login, String password) async {
    Map<String, dynamic> jsonData = {
      'login': login,
      'password': password
    };

    var response = await http.get(Uri.https(authority, '${unencodedPath}Auth', jsonData));

    User? user;

    if(response.statusCode == 200){
      var jsonData = jsonDecode(response.body);
      user = User.fromJson(jsonData);
    }

    return user;
  }
}
