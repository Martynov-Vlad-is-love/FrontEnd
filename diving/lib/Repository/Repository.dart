
abstract class Repository<T>{
  Future<List<T>> getAllData();
  Future<T> getDataById(int id);
  Future<void> postData(T type);
  Future<void> updateData(T type);
  Future<void> deleteData(int id);
}