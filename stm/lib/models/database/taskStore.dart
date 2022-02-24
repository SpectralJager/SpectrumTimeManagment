import 'dart:developer';

import 'package:sembast/sembast.dart';
import 'package:stm/models/database/db.dart';
import 'package:stm/models/task.dart';
import 'package:stm/utils/Categories.dart';

class TaskStore extends DB {
  late final StoreRef _task_store;

  @override
  Future init({required String db_name}) async {
    await super.init(db_name: db_name);
    this._task_store = intMapStoreFactory.store("task_store");
    return Future.delayed(Duration(seconds: 10));
  }

  Future<List<Task>> fetchTasks() async {
    try {
      final snapshot = await this._task_store.find(this.database);
      return snapshot
          .map((element) => Task.fromMap(element.key, element.value))
          .toList();
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future<Task> fetchTask(int id) async {
    return await this._task_store.record(id).getSnapshot(this.database).then(
      (snap) {
        if (snap != null) {
          return Task.fromMap(snap.key, snap.value);
        }
        return Task(id: id, name: "", category: Categories.other, phases: []);
      },
    );
  }

  void addTask(Task task) async {
    try {
      await this._task_store.add(this.database, task.toMap());
    } catch (e) {
      log(e.toString());
    }
  }

  void editTask(Task task) async {
    try {
      await this
          ._task_store
          .record(task.id)
          .update(this.database, task.toMap());
    } catch (e) {
      log(e.toString());
    }
  }

  void deleteTask(Task task) async {
    try {
      await this._task_store.record(task.id).delete(this.database);
    } catch (e) {
      log(e.toString());
    }
  }
}
