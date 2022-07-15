import '../Models/UserCourse.dart';
import '../Repository/UserCourseRepository.dart';

class UserCourseController{
  final UserCourseRepository _userCourseRepository;
  UserCourseController(this._userCourseRepository);

  Future<void> postUserCourse(UserCourse userCourse) async{
    await _userCourseRepository.postData(userCourse);
  }

  Future<List<UserCourse>> getUserCoursesList() async{
    return await _userCourseRepository.getAllData();
  }

  Future<UserCourse> getUserCourseData(int id) async{
    return await _userCourseRepository.getDataById(id);
  }
  Future<List<UserCourse>> getUserCourseDataByUserId(int id) async{
    return await _userCourseRepository.getDataByUserId(id);
  }

  Future<void> updateUserCourseData(UserCourse userCourse) async{
    await _userCourseRepository.updateData(userCourse);
  }

  Future<void> deleteUserCourse(int id) async{
    await _userCourseRepository.deleteData(id);
  }
  Future<void> deleteUserCoursesByUserId(int id) async{
    await _userCourseRepository.deleteDataByUserId(id);
  }

}