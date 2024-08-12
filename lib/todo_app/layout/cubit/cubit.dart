import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/todo_app/layout/cubit/state.dart';
import 'package:messenger/todo_app/modules/archive/archive_tasks.dart';
import 'package:messenger/todo_app/modules/done/done_tasks.dart';
import 'package:messenger/todo_app/modules/new/new_tasks.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as p;

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool isShowBottom = false;
  List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.menu),
      label: 'New',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.check_box_outlined),
      label: 'Done',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.archive_outlined),
      label: 'Archive',
    ),
  ];
  List<Widget> screens = [
    const NewTasks(),
    const DoneTasks(),
    const ArchiveTasks(),
  ];
  List<String> titles = [
    'New',
    'Done',
    'Archive',
  ];
  IconData fabIcon = Icons.edit;
  int currentIndex = 0;
  Database? database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archiveTasks = [];
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  void changeFabIcon({
    required bool isShow,
    required IconData icon,
  }) {
    isShowBottom = isShow;
    fabIcon = icon;
    emit(AppChangeFabIconState());
  }

  void changeBottomNav(index) {
    currentIndex = index;
    emit(AppChangeBottomNavState());
  }

  void createDataFromDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, 'tasks.db');
    openDataFromDatabase(path: path);
    emit(AppCreateDataFromDatabaseState());
  }

  void openDataFromDatabase({
    required String path,
  }) async {
    await openDatabase(
      path,
      version: 1,
      onCreate: (
        Database database,
        int version,
      ) async {
        debugPrint('Database created');
        await database
            .execute(
          'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, time TEXT, date TEXT, status TEXT)',
        )
            .then(
          (value) {
            debugPrint('Table created');
          },
        ).catchError(
          (error) {
            debugPrint('Error when table created ${error.toString()}');
          },
        );
      },
      onOpen: (database) {
        getDataFromDatabase(database);
        emit(AppOpenDataFromDatabaseState());
        debugPrint('Database opened');
      },
    ).then(
      (value) {
        database = value;
      },
    );
  }

  void insertDataFromDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database!.transaction((txn) async {
      txn
          .rawInsert(
        'INSERT INTO tasks(title, time, date, status) VALUES("$title", "$time", "$date" , "new")',
      )
          .then(
        (value) {
          getDataFromDatabase(database);
          emit(AppInsertDataFromDatabaseState());
          debugPrint('$value Inserted successfully');
        },
      ).catchError(
        (error) {
          debugPrint('Error when data inserted ${error.toString()}');
        },
      );
    });
  }

  void getDataFromDatabase(database) async {
    newTasks = [];
    doneTasks = [];
    archiveTasks = [];
    await database.rawQuery('SELECT * FROM tasks').then(
      (value) {
        value.forEach((element) {
          if (element['status'] == 'new') {
            newTasks.add(element);
          } else if (element['status'] == 'done') {
            doneTasks.add(element);
          } else {
            archiveTasks.add(element);
          }
        });
      },
    );
  }

  void updateDataFromDatabase({
    required String status,
    required int id,
  }) async {
    await database!.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      [status, id],
    ).then(
      (value) {
        getDataFromDatabase(database);
        emit(AppUpdateDataFromDatabaseState());
      },
    );
  }

  void deleteDataFromDatabase({
    required int id,
  }) async {
    await database!.rawDelete(
      'DELETE FROM tasks WHERE id = ?',
      [id],
    ).then(
      (value) {
        getDataFromDatabase(database);
        emit(AppDeleteDataFromDatabaseState());
      },
    );
  }
}
