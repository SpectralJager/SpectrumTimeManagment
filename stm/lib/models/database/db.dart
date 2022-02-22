import 'dart:developer';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast_io.dart';

class DB {
  late final Database _database;
  Database get database => _database;

  void init({required String db_name}) async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      await appDir.create(recursive: true);
      final databasePath = join(appDir.path, db_name);
      this._database = await databaseFactoryIo.openDatabase(databasePath);
      log('database $db_name initialized/opened successfully!');
    } catch (e) {
      log(e.toString());
      exit(500);
    }
  }
}
