abstract class DataSource<T> {
  Future<T> createOrUpdate(T data);

  Future<void> delete(T data);

  Future<void> deleteById(dynamic id);

  Future<void> deleteAll();

  Future<List<T>> getData({String keyword = ''});
}
