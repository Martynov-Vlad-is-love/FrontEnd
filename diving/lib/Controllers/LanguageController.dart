
import 'package:diving/Models/Language.dart';
import 'package:diving/Repository/LanguageRepository.dart';

class LanguageController{
  final LanguageRepository _languageRepository;
  LanguageController(this._languageRepository);

  Future<List<Language>> getLanguagesList() async{
    return _languageRepository.getAllData();
  }

  Future<List<Language>> getLanguageData(int id) async{
    return _languageRepository.getDataById(id);
  }

  Future<List<Language>> updateLanguageData(language) async{
    await _languageRepository.updateData(language);
    return getLanguageData(language.id!);
  }

}