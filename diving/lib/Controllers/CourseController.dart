
import 'package:diving/Models/Course.dart';
import 'package:diving/Repository/CourseRepository.dart';

class CourseController{
  final CourseRepository _courseRepository;
  CourseController(this._courseRepository);

  Future<void> postCourse(Course course) async{
    await _courseRepository.postData(course);
  }
  Future<List<Course>> getCoursesList() async{
    return await _courseRepository.getAllData();
  }

  Future<List<Course>> getCourseData(int id) async{
    return await _courseRepository.getDataById(id);
  }

  Future<void> updateCourseData(Course course) async{
    await _courseRepository.updateData(course);
  }

  Future<void> deleteCourse(int id) async{
    await _courseRepository.deleteData(id);

  }

}