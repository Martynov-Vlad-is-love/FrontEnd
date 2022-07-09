
import 'package:diving/Models/Role.dart';
import '../Repository/RoleRepository.dart';

class RoleController{
  final RoleRepository _roleRepository;
  RoleController(this._roleRepository);

  Future<List<Role>> getRolesList() async{
    return _roleRepository.getAllData();
  }

  Future<List<Role>> getRoleData(int id) async{
    return _roleRepository.getDataById(id);
  }

  Future<List<Role>> updateRoleData(Role role) async{
    await _roleRepository.updateData(role);
    return getRoleData(role.id!);
  }

}