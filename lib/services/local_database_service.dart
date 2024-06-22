import 'package:hive_local_storage/hive_local_storage.dart';

import '../app/app.logger.dart';

class LocalDatabaseService {
  late LocalStorage _db;
  final _logger = getLogger('LocalDatabaseService');

  Future<void> init() async {
    _db = await LocalStorage.getInstance();
  }

  Future<void> cleanDb() async {
    await _db.clear();
  }

  Future<void> save(
      {required String key, required dynamic value, bool log = false}) async {
    await _db.put(key: key, value: value).then((_) {
      if (log) {
        _logger.d('stored $key -> $value');
      }
    });
  }

  Future<void> delete({required String key}) async {
    await _db.remove(key: key);
  }

  dynamic get({required String key}) {
    return _db.get(key: key);
  }
}
