import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/core/ulits/app_string.dart';
import 'package:to_do_app/core/ulits/cubit/states.dart';

import '../../../presentation/home_board/pages/all_task_screen.dart';
import '../../../presentation/home_board/pages/completed_screen.dart';
import '../../../presentation/home_board/pages/favourite_screen.dart';
import '../../../presentation/home_board/pages/uncompleted_screen.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  late Database database;
  static final int version = 1;
  int currentIndex = 0;
  int selectedRemind = 5;
  int selectTaskColor = 0;
  int? id;
  List<int> remindList = [5, 10, 20, 30, 40, 50];
  List<String> repeatList = [
    AppStrings.none,
    AppStrings.daily,
    AppStrings.weekly,
    AppStrings.monthly
  ];

  List<Map> tasks = [];
  List<Map> completedTasks = [];
  List<Map> unCompletedTasks = [];
  List<Map> favouriteTasks = [];

  List<Widget> tabsScreens = [
    AllTasksScreen(),
    CompletedScreen(),
    FavouriteScreen(),
    UncompletedScreen(),
  ];

  //buttomNavFn
  void changeNavTabBar(int index) {
    currentIndex = index;
    emit(AppChangeNavTabBarState());
  }

  void changeColor(int index) {
    selectTaskColor = index;
    emit(AppChangeColorState());
  }

  //CheckBoxFn
  bool value = false;
  void checkbox(bool) {
    value = bool;
    emit(AppCheckBoxState());
  }

  void createDataBase() {
    openDatabase(
      'todo.db',
      version: version,
      onCreate: (database, version) {
        print('database created');
        database
            .execute(
                'CREATE TABLE ${AppStrings.tableName} (id INTEGER PRIMARY KEY, title TEXT, date TEXT, startTime TEXT, endTime TEXT, remind INTEGER, repeat TEXT, color INTEGER, status TEXT, favourite TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('Error When Creating Table ${error.toString()}');
        });
      },
      onOpen: (Database db) {
        database = db;
        print('database opened');
        getTasksData();
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertToDatabase({
    required String title,
    required String date,
    required String startTime,
    required String endTime,
    required int remind,
    required String repeat,
    required int color,
  }) async {
    await database.transaction((txn) async {
      return await txn
          .rawInsert(
        'INSERT INTO ${AppStrings.tableName}(title, date, startTime, endTime, remind, repeat, color, status,favourite ) VALUES("$title", "$date", "$startTime", "$endTime", $remind, "$repeat", "$color", "unComplete", "unFavourite")',
      )
          .then((value) {
        print('$value inserted successfully');
        emit(AppInsertDatabaseState());
        getTasksData();
      }).catchError((error) {
        print('Error When Inserting New Record ${error.toString()}');
      });
    });
  }

  void getTasksData() async {
    tasks = [];
    completedTasks = [];
    unCompletedTasks = [];
    favouriteTasks = [];
    emit(AppDatabaseLoadingState());
    await database
        .rawQuery('SELECT * FROM ${AppStrings.tableName}')
        .then((value) {
      debugPrint('Fatch Data');
      tasks = value;
      print(tasks);
      value.forEach(
        (task) {
          if (task['${AppStrings.status}'] == '${AppStrings.unComplete}') {
            if (task['${AppStrings.favourite}'] == 'isFavourite') {
              favouriteTasks.add(task);
            } else {
              unCompletedTasks.add(task);
            }
          }

          if (task['${AppStrings.status}'] == '${AppStrings.complete}') {
            if (task['${AppStrings.favourite}'] == 'isFavourite') {
              favouriteTasks.add(task);
            } else {
              completedTasks.add(task);
            }
          }
        },
      );

      emit(AppGetTasksDatabaseState());
    });
  }

  void updateData({
    required String status,
    required int id,
  }) async {
    database.rawUpdate(
      'UPDATE ${AppStrings.tableName} SET status = ? WHERE id = ?',
      [
        '$status',
        id,
      ],
    ).then((value) {
      getTasksData();
      emit(AppUpdateTasksDatabaseState());
    });
  }

  void updateFavData({
    required String favourite,
    required int id,
  }) async {
    database.rawUpdate(
      'UPDATE ${AppStrings.tableName} SET favourite = ? WHERE id = ?',
      [
        '$favourite',
        id,
      ],
    ).then((value) {
      getTasksData();
      emit(AppUpdateTasksFavDatabaseState());
    });
  }

  void deleteData({
    required var id,
  }) async {
    database.rawDelete(
        'DELETE FROM ${AppStrings.tableName} WHERE id = ?', [id]).then((value) {
      getTasksData();
      emit(AppDeleteTasksDatabaseState());
    });
  }
}
