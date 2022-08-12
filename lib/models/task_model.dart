import 'package:to_do_app/core/ulits/app_string.dart';

class TaskModel {
  int? id;
  String? title;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? color;
  int? remind;
  String? repeat;

  TaskModel({
    this.id,
    this.title,
    this.isCompleted,
    this.date,
    this.startTime,
    this.endTime,
    this.color,
    this.remind,
    this.repeat,
  });

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json[AppStrings.id];
    title = json[AppStrings.title];
    isCompleted = json[AppStrings.isCompleted];
    date = json[AppStrings.date];
    startTime = json[AppStrings.startTime];
    endTime = json[AppStrings.endTime];
    color = json[AppStrings.color];
    remind = json[AppStrings.remind];
    repeat = json[AppStrings.repeat];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[AppStrings.id] = this.id;
    data[AppStrings.title] = this.title;
    data[AppStrings.isCompleted] = this.isCompleted;
    data[AppStrings.startTime] = this.startTime;
    data[AppStrings.endTime] = this.endTime;
    data[AppStrings.color] = this.color;
    data[AppStrings.remind] = this.remind;
    data[AppStrings.repeat] = this.repeat;
    return data;
  }
}
