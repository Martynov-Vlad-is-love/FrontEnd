class PromoCode{
  int? id;
  String? promoCode;
  bool? isActive;
  double? discount;

  PromoCode(this.id, this.promoCode, this.isActive, this.discount);

  PromoCode.fromJson(Map<String, dynamic> json){
    id = json["id"];
    promoCode = json["promoCode"];
    isActive = json["isActive"];
    discount = json["discount"];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["promoCode"] = this.promoCode;
    data["isActive"] = this.isActive;
    data["discount"] = this.discount;
    return data;
  }
}