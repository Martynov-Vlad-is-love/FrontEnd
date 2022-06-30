class Course{
  int? id;
  String? courseName;
  double? cost;
  String? description;
  int? minHoursUnderWater;
  String? image;

  Course(this.id,this.courseName,this.cost,this.description,this.minHoursUnderWater,this.image);

  Course.fromJson(Map<String, dynamic> json){
    id = json["id"];
    courseName = json["courseName"];
    cost = json["cost"];
    description = json["description"];
    minHoursUnderWater = json["minHoursUnderWater"];
    image = json["image"];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["courseName"] = this.courseName;
    data["cost"] = this.cost;
    data["description"] = this.description;
    data["minHoursUnderWater"] = this.minHoursUnderWater;
    data["image"] = this.image;
    return data;
  }

}