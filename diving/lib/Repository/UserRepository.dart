import 'dart:convert';

import 'package:diving/Models/User.dart';
import 'package:http/http.dart' as http;

import 'Repository.dart';

class UserRepository implements Repository{
  final authority = 'localhost:44329';
  final unencodedPath = 'api/Users/';

  String unencodedPathById(int id) {
    return 'api/Users/{$id}';
  }

  Future<void> postData(user) async {
    try {
      var response = await http.post(Uri.https(authority, unencodedPath),
          body: user.toJson());
      print("Status code ${response.statusCode}");
    } catch (ex) {
      print(ex);
    }
  }

  Future<List<User>> getAllData() async {
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

  Future<List<User>> getDataById(int id) async {
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

  @override
  Future<void> updateData(user) async {
    var jsonMap = user.toJson();
    for (var item in jsonMap.keys) {
      print("$item: ${jsonMap[item]}, ${jsonMap[item].runtimeType}");
    }
    var _jsonEncoded = jsonEncode(jsonMap);
    var response = await http.put(
        Uri.https(authority, unencodedPathById(user.id!)),
        body: _jsonEncoded,
        headers: {
          'content-type': 'application/json',
          "Accept": "application/json"
        });

    print("Status code: ${response.statusCode}");
  }

  @override
  Future<void> deleteData(int id) async {
    Map<String, int> userId = {'Id': id};
    await http.delete(Uri.https(authority, unencodedPath, userId));
  }

  Future<User?> authentication(String login, String password) async {
    Map<String, dynamic> jsonData = {'login': login, 'password': password};

    var response =
        await http.get(Uri.https(authority, '${unencodedPath}Auth', jsonData));

    User? user;

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      user = User.fromJson(jsonData);
    }

    return user;
  }


}
