
import 'package:diving/Models/Course.dart';
import 'package:diving/Repository/CourseRepository.dart';

class CourseController{
  final CourseRepository _courseRepository;
  CourseController(this._courseRepository);

  Future<List<Course>> getCoursesList() async{
    return _courseRepository.getAllData();
  }

  Future<List<Course>> getCourseData(int id) async{
    return _courseRepository.getDataById(id);
  }

  Future<List<Course>> updateCourseData(Course course) async{
    await _courseRepository.updateData(course);
    return getCourseData(course.id!);
  }

}