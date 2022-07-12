class User {
  int? id;
  String? login;
  String? password;
  String? name;
  String? surname;
  int? age;
  double? maxDepth;
  double? hoursUnderWater;
  String? registrationDate;
  String? disease;
  String? phoneNumber;
  int? roleId;
  int? languageId;

  User(
      this.id,
      this.login,
      this.password,
      this.name,
      this.surname,
      this.age,
      this.maxDepth,
      this.hoursUnderWater,
      this.registrationDate,
      this.disease,
      this.phoneNumber,
      this.roleId,
      this.languageId);

  User.fromJson(Map<String, dynamic> json) {
    id = json["id"] as int?;
    login = json["login"];
    password = json["password"];
    name = json["name"];
    surname = json["surname"];
    age = json["age"] as int?;
    maxDepth = json["maxDepth"] as double?;
    hoursUnderWater = json["hoursUnderWater"] as double?;
    registrationDate = json["registrationDate"];
    disease = json["disease"];
    phoneNumber = json["phoneNumber"];
    roleId = json["roleId"] as int?;
    languageId = json["languageId"] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{
      "login": this.login,
      "password": this.password,
      "name": this.name,
      "surname": this.surname,
      "age": this.age.toString(),
      "maxDepth": this.maxDepth.toString(),
      "hoursUnderWater": this.hoursUnderWater.toString(),
      "registrationDate": this.registrationDate.toString(),
      "disease": this.disease,
      "phoneNumber": this.phoneNumber,
      "roleId": this.roleId.toString(),
      "languageId": this.languageId.toString(),
    };
    return data;
  }
  Map<String, String?> registrationToJson() {
    final Map<String, String?> data = <String, String?>{
      "login": this.login,
      "password": this.password,
      "name": this.name,
      "surname": this.surname,
      "age": this.age.toString(),
      "maxDepth": this.maxDepth.toString(),
      "hoursUnderWater": this.hoursUnderWater.toString(),
      "registrationDate": this.registrationDate.toString(),
      "disease": this.disease,
      "phoneNumber": this.phoneNumber,
      "roleId": this.roleId.toString(),
      "languageId": this.languageId.toString(),
    };
    return data;
  }
}
