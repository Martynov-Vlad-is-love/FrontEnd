class Language {
  int? id;
  String? languageName;

  Language(this.id, this.languageName);

  Language.fromJson(Map<String, dynamic> json){
    id = json["id"];
    languageName = json["languageName"];
  }
}