import 'package:diving/Models/Course.dart';
import '../Models/UserCourse.dart';
import '../Repository/UserCourseRepository.dart';

class UserCourseController{
  final UserCourseRepository _userCourseRepository;
  UserCourseController(this._userCourseRepository);

  Future<List<UserCourse>> getUserCoursesList() async{
    return _userCourseRepository.getAllData();
  }

  Future<List<UserCourse>> getUserCourseData(int id) async{
    return _userCourseRepository.getDataById(id);
  }

  Future<List<UserCourse>> updateUserCourseData(Course course) async{
    await _userCourseRepository.updateData(course);
    return getUserCourseData(course.id!);
  }

  Future<void> deleteUserCourse(int id) async{
    await _userCourseRepository.deleteData(id);
  }
  Future<void> deleteUserCoursesByUserId(int id) async{
    await _userCourseRepository.deleteDataByUserId(id);
  }

}