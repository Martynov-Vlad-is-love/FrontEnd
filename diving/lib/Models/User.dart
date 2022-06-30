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
    id = json["id"];
    login = json["login"];
    password = json["password"];
    name = json["name"];
    surname = json["surname"];
    age = json["age"];
    maxDepth = json["maxDepth"];
    hoursUnderWater = json["hoursUnderWater"];
    registrationDate = json["registrationDate"];
    disease = json["disease"];
    phoneNumber = json["phoneNumber"];
    roleId = json["roleId"];
    languageId = json["languageId"];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["login"] = this.login;
    data["password"] = this.password;
    data["name"] = this.name;
    data["surname"] = this.surname;
    data["age"] = this.age;
    data["maxDepth"] = this.maxDepth;
    data["hoursUnderWater"] = this.hoursUnderWater;
    data["registrationDate"] = this.registrationDate;
    data["disease"] = this.disease;
    data["phoneNumber"] = this.phoneNumber;
    data["roleId"] = this.disease;
    data["languageId"] = this.phoneNumber;
    return data;
  }
}