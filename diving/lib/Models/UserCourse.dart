class UserCourse{
  int? id;
  int? userId;
  int? courseId;
  bool? available;
  int? completed;
  int? promoCodeId;
  int? totalPrice;

  UserCourse(this.id, this.userId, this.courseId,this.available, this.completed, this.promoCodeId, this.totalPrice);

  UserCourse.fromJson(Map<String, dynamic> json){
    id = json["id"];
    userId = json["userId"];
    courseId = json["courseId"];
    available = json["available"];
    completed = json["completed"];
    promoCodeId = json["promoCodeId"];
    totalPrice = json["totalPrice"];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["userId"] = this.userId;
    data["courseId"] = this.courseId;
    data["available"] = this.available;
    data["completed"] = this.completed;
    data["promoCodeId"] = this.promoCodeId;
    data["totalPrice"] = this.totalPrice;
    return data;
  }
}