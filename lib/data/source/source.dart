abstract class DataSource<T> {
  Future<int> create(T data);
  
  Future<T> update(T data);

  Future<void> delete(dynamic id);

  Future<List<T>> getData({String keyword = ''});

  //maybe search
}
