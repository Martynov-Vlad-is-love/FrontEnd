class UserCourse{
  int? id;
  int? userId;
  int? courseId;
  bool? available;
  int? completed;
  int? promoCodeId;
  double? totalPrice;

  UserCourse(this.id, this.userId, this.courseId,this.available, this.completed, this.promoCodeId, this.totalPrice);

  UserCourse.fromJson(Map<String, dynamic> json){
    id = json["id"] as int?;
    userId = json["userId"] as int?;
    courseId = json["courseId"] as int?;
    available = json["availible"] as bool?;
    completed = json["completed"] as int?;
    promoCodeId = json["promoCodeId"] as int?;
    totalPrice = json["totalPrice"] as double?;
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["userId"] = this.userId.toString();
    data["courseId"] = this.courseId.toString();
    data["availible"] = this.available;
    data["completed"] = this.completed.toString();
    data["promoCodeId"] = this.promoCodeId.toString();
    data["totalPrice"] = this.totalPrice.toString();
    return data;
  }
}