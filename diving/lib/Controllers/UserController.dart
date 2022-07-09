
import 'package:diving/Models/User.dart';
import 'package:diving/Repository/UserRepository.dart';

class UserController{
  final UserRepository _userRepository;
  UserController(this._userRepository);

  Future<User?> authentication(String login, String password) async{
    return _userRepository.authentication(login, password);
  }

  Future<List<User>> getUsersList() async{
    return _userRepository.getAllData();
  }

  Future<List<User>> getUserData(int id) async{
    return _userRepository.getDataById(id);
  }

  Future<List<User>> updateUserData(User user) async{
    await _userRepository.updateData(user);
    return getUserData(user.id!);
  }


}