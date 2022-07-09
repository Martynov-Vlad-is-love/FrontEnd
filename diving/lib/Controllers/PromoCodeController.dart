import 'package:diving/Models/Course.dart';
import 'package:diving/Models/PromoCode.dart';
import 'package:diving/Repository/PromoCodeRepository.dart';

class PromoCodeController{
  final PromoCodeRepository _promoCodeRepository;
  PromoCodeController(this._promoCodeRepository);

  Future<List<PromoCode>> getPromoCodesList() async{
    return _promoCodeRepository.getAllData();
  }

  Future<List<PromoCode>> getPromoCodeData(int id) async{
    return _promoCodeRepository.getDataById(id);
  }

  Future<List<PromoCode>> updatePromoCodeData(Course course) async{
    await _promoCodeRepository.updateData(course);
    return getPromoCodeData(course.id!);
  }

}