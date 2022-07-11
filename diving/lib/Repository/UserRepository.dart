import 'dart:convert';

import 'package:diving/Models/User.dart';
import 'package:http/http.dart' as http;

import 'Repository.dart';

class UserRepository implements Repository{
  final authority = 'localhost:44329';
  final unencodedPath = 'api/Users';

  String unencodedPathById(int id) {
    return 'api/Users/$id';
  }

  @override
  Future<void> postData(user) async {
    var jsonMap = user.toJson();
    try {
      var response = await http.post(Uri.https(authority, unencodedPath),
          body: jsonEncode(jsonMap),
          headers: {
            'Content-type': 'application/json',
            "Accept": "application/json"
          });
      print(jsonEncode(jsonMap));
      print("Status code ${response.body}");
    } catch (ex) {
      print(ex);
    }
  }

  Future<void> registration(User user) async {
    try {
      var jsonMap = user.registrationToJson();

      for (var item in jsonMap.keys) {
        print("$item: ${jsonMap[item]}, ${jsonMap[item].runtimeType}");
      }

      var response = await http.post(Uri.https(authority, 'api/Users/Registration', jsonMap));
      print("Status code ${response.body}");
    } catch (ex) {
      print(ex);
    }
  }

  @override
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

  @override
  Future<User?> getDataById(int id) async {
    try {
      var response = await http.get(Uri.https(authority, unencodedPathById(id)));
      if(response.statusCode == 200){
        var jsonData = jsonDecode(response.body);
        User? user = User.fromJson(jsonData);
        return user;
      }

      return null;

    } catch (ex) {
      print(ex);
    }
    return null;
  }



  Future<User?> authentication(String login, String password) async {
    User? user;
    try{
      Map<String, dynamic> jsonData = {'login': login, 'password': password};

      var response = await http.get(Uri.https(authority, '${unencodedPath}/Auth', jsonData));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        user = User.fromJson(jsonData);
      }
      return user;
    }catch(ex){
      print(ex);
      return user;
    }

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
          'Content-type': 'application/json',
          "Accept": "application/json"
        });
        print("Status code: ${response.body}");
  }

  @override
  Future<void> deleteData(int id) async {
    var response = await http.delete(Uri.https(authority, 'api/Users/$id'));
    print(response.body);
  }
}
