class User{
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

  User(this.id, this.login, this.password, this.name, this.surname, this.age, this.maxDepth, this.hoursUnderWater, this.registrationDate, this.disease, this.phoneNumber, this.roleId,this.languageId);

  User.fromJson(Map<String, dynamic> json){
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

  Map<String, String?> toJson(){
    final Map<String, String?> data = new Map<String, String?>();
    data["Login"] = this.login;
    data["Password"] = this.password;
    data["Name"] = this.name;
    data["Surname"] = this.surname;
    data["Age"] = this.age.toString();
    data["MaxDepth"] = this.maxDepth.toString();
    data["HoursUnderWater"] = this.hoursUnderWater.toString();
    data["RegistrationDate"] = this.registrationDate;
    data["Disease"] = this.disease;
    data["PhoneNumber"] = this.phoneNumber;
    data["RoleId"] = this.roleId.toString();
    data["LanguageId"] = this.languageId.toString();
    return data;
  }
}