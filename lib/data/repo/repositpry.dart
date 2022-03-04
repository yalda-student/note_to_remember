import 'package:flutter/widgets.dart';
import 'package:yalda_students_notes/data/source/source.dart';

class Repository<T> extends ChangeNotifier implements DataSource<T> {
  final DataSource<T> localDataSource;

  Repository(this.localDataSource);

  // @override
  // Future<T> createOrUpdate(T data) async {
  //   var result = await localDataSource.createOrUpdate(data);
  //   notifyListeners();
  //   return result;
  // }

    @override
  Future<int> create(T data) {
    throw UnimplementedError();
  }

  @override
  Future<T> update(T data) {
    throw UnimplementedError();
  }


  @override
  Future<void> delete(id) async {
    await localDataSource.delete(id);
    notifyListeners();
  }

  @override
  Future<List<T>> getData({String keyword = ''}) {
    return localDataSource.getData(keyword: keyword);
  }


}
