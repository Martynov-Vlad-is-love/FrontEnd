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
  Future<PromoCode> getPromoCodeDataByName(String promoCode) async{
    return _promoCodeRepository.getDataByName(promoCode);
  }

  Future<void> updatePromoCodeData(PromoCode promoCode) async{
    await _promoCodeRepository.updateData(promoCode);
  }

  Future<void> deletePromoCode(int id) async{
    await _promoCodeRepository.deleteData(id);
  }

  Future<void> postPromoCode(PromoCode promoCode) async{
    await _promoCodeRepository.postData(promoCode);
  }

}