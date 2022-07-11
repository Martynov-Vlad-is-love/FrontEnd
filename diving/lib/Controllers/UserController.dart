
import 'package:diving/Models/User.dart';
import 'package:diving/Repository/UserRepository.dart';

class UserController{
  final UserRepository _userRepository;
  UserController(this._userRepository);

  Future<User?> authentication(String login, String password) async{
    return _userRepository.authentication(login, password);
  }

  Future<void> registration(User user) async{
    return _userRepository.registration(user);
  }

  Future<List<User>> getUsersList() async{
    return _userRepository.getAllData();
  }

  Future<User?> getUserData(int id) async{
    return _userRepository.getDataById(id);
  }

  Future<void> updateUserData(User user) async{
    await _userRepository.updateData(user);
  }

  Future<User?> postUserData(User user) async{
    await _userRepository.postData(user);
    return getUserData(user.id!);
  }

  Future<void> deleteUser(int id) async{
    await _userRepository.deleteData(id);
  }

}