import 'dart:convert';

import 'package:diving/Models/PromoCode.dart';
import 'package:diving/Repository/Repository.dart';
import 'package:http/http.dart' as http;

class PromoCodeRepository implements Repository{

  final authority = 'localhost:44329';
  final unencodedPath = 'api/PromoCode';

  String unencodedPathById(int id) {
    return '$unencodedPath/$id';
  }

  @override
  Future<void> deleteData(int id) async{
    await http.delete(Uri.https(authority, unencodedPathById(id)));
  }

  @override
  Future<List<PromoCode>> getAllData() async{
    List<PromoCode> promoCodes = [];
    try {
      var response = await http.get(Uri.https(authority, unencodedPath));
      var jsonData = jsonDecode(response.body);

      for (int i = 0; i < jsonData.length; i++) {
        promoCodes.add(PromoCode.fromJson(jsonData[i]));
      }
    } catch (ex) {
      print(ex);
    }
    return promoCodes;
  }

  @override
  Future<List<PromoCode>> getDataById(int id) async{
    // TODO: implement getDataById
    throw UnimplementedError();
  }
  
  Future<PromoCode> getDataByName(String name) async{
    var response = await http.get(Uri.https(authority, "$unencodedPath/Only/$name"));
    var jsonData = jsonDecode(response.body);
    PromoCode promoCode = PromoCode.fromJson(jsonData);
    return promoCode;
  }

  @override
  Future<void> postData(promoCode) async{
    var jsonMap = promoCode.toJson();

    for (var item in jsonMap.keys) {
      print("$item: ${jsonMap[item]}, ${jsonMap[item].runtimeType}");
    }

    var response = await http.post(Uri.https(authority, unencodedPath, jsonMap));

    print(response.body);
  }

  @override
  Future<void> updateData(promoCode) async{
    var jsonMap = promoCode.toJson();

    var response = await http.put(Uri.https('localhost:44329', unencodedPathById(promoCode.id)),
        body: jsonEncode(jsonMap),
        headers: {
          'Content-type': 'application/json',
          "Accept": "application/json"
        }
    );
    print(response.body);
  }

}