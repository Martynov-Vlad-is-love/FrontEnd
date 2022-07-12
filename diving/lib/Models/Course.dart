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
    final Map<String, dynamic> data = <String, dynamic>{
      "id": this.id.toString(),
      "courseName": this.courseName,
      "cost": this.cost.toString(),
      "description": this.description,
      "minHoursUnderWater": this.minHoursUnderWater.toString(),
      "image": this.image,
    };
    return data;
  }

}