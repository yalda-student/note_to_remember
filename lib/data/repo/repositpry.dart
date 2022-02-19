import 'package:flutter/widgets.dart';
import 'package:yalda_students_notes/data/source/source.dart';

class Repository<T> extends ChangeNotifier implements DataSource<T> {
  final DataSource<T> localDataSource;

  Repository(this.localDataSource);

  @override
  Future<T> createOrUpdate(T data) async {
    var result = await localDataSource.createOrUpdate(data);
    notifyListeners();
    return result;
  }

  @override
  Future<void> delete(T data) async {
    await localDataSource.delete(data);
    notifyListeners();
  }

  @override
  Future<void> deleteAll() async {
    await localDataSource.deleteAll();
    notifyListeners();
  }

  @override
  Future<void> deleteById(id) async {
    await localDataSource.deleteById(id);
    notifyListeners();
  }

  @override
  Future<List<T>> getData({String keyword = ''}) {
    return localDataSource.getData(keyword: keyword);
  }
}
