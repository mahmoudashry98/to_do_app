import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/ulits/app_string.dart';
import 'package:to_do_app/core/ulits/cubit/cubit.dart';
import 'package:to_do_app/core/ulits/cubit/states.dart';
import 'package:to_do_app/core/ulits/media_query_values.dart';
import 'package:to_do_app/presentation/add_task/widgets/customFormField.dart';
import 'package:to_do_app/presentation/home_board/home_board_screen.dart';

import '../../core/ulits/app_colors.dart';
import '../../core/ulits/widget/custom_button.dart';

import 'package:intl/intl.dart';

import '../../core/ulits/widget/custom_text.dart';
import '../../core/ulits/widget/navigate_widget.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dateController = TextEditingController();
    var startTimeController = TextEditingController();
    var endTimeController = TextEditingController();
    var titleController = TextEditingController();
    var remindController = TextEditingController();
    var repeatController = TextEditingController();
    var scaffoldKey = GlobalKey<ScaffoldState>();
    var formKey = GlobalKey<FormState>();

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        int selectedRemind = cubit.selectedRemind;
        DateTime dateTime = DateTime.now();
        List<int> remindList = cubit.remindList;
        List<String> repeatList = cubit.repeatList;
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: CustomText(
              text: AppStrings.addTask,
              color: AppColors.textBlack,
              fontWeight: FontWeight.bold,
              size: 20,
            ),
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomFormField(
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return AppStrings.validTitle;
                      }
                      return null;
                    },
                    controller: titleController,
                    title: AppStrings.title,
                    hintText: AppStrings.hintTitle,
                  ),
                  CustomFormField(
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return AppStrings.validDate;
                      }
                      return null;
                    },
                    controller: dateController,
                    hintText: '${DateFormat.yMd().format(dateTime)}',
                    title: AppStrings.deadline,
                    icon: Icons.keyboard_arrow_down_outlined,
                    press: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.parse('2025-10-10'),
                      ).then((value) {
                        dateController.text = DateFormat.yMd().format(value!);
                      });
                    },
                  ),
                  Row(
                    children: [
                      CustomFormField(
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return AppStrings.validtime;
                          }
                          return null;
                        },
                        width: 150,
                        title: AppStrings.startTime,
                        hintText: '${DateFormat('hh:mm a').format(dateTime)}',
                        icon: Icons.watch_later_outlined,
                        controller: startTimeController,
                        press: () {
                          showTimePicker(
                                  initialEntryMode: TimePickerEntryMode.input,
                                  context: context,
                                  initialTime: TimeOfDay.now())
                              .then((value) {
                            startTimeController.text =
                                value!.format(context).toString();
                          });
                        },
                      ),
                      CustomFormField(
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return AppStrings.validtime;
                          }
                          return null;
                        },
                        width: 150,
                        title: AppStrings.endTime,
                        hintText: '14:00 Pm',
                        icon: Icons.watch_later_outlined,
                        controller: endTimeController,
                        press: () {
                          showTimePicker(
                                  initialEntryMode: TimePickerEntryMode.input,
                                  context: context,
                                  initialTime: TimeOfDay.now())
                              .then((value) {
                            endTimeController.text =
                                value!.format(context).toString();
                          });
                        },
                      ),
                    ],
                  ),
                  CustomFormField(
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return AppStrings.validRemind;
                      }
                      return null;
                    },
                    controller: remindController,
                    title: AppStrings.remind,
                    hintText: '$selectedRemind minute early',
                    dropDown: DropdownButton(
                      icon: Icon(
                        Icons.keyboard_arrow_down_outlined,
                        size: 35,
                        color: Colors.grey[400],
                      ),
                      onChanged: (String? newValue) {
                        remindController.text = newValue!;
                      },
                      underline: Container(
                        color: Colors.white,
                      ),
                      items:
                          remindList.map<DropdownMenuItem<String>>((int value) {
                        return DropdownMenuItem<String>(
                          child: Text(value.toString()),
                          value: value.toString(),
                        );
                      }).toList(),
                    ),
                  ),
                  CustomFormField(
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return AppStrings.validRepeat;
                      }
                      return null;
                    },
                    controller: repeatController,
                    title: AppStrings.repeat,
                    hintText: '${AppStrings.none}',
                    dropDown: DropdownButton(
                      icon: Icon(
                        Icons.keyboard_arrow_down_outlined,
                        size: 35,
                        color: Colors.grey[400],
                      ),
                      onChanged: (String? newValue) {
                        repeatController.text = newValue!;
                      },
                      underline: Container(
                        color: Colors.white,
                      ),
                      items: repeatList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          child: Text(value.toString()),
                          value: value.toString(),
                        );
                      }).toList(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        CustomText(
                          text: AppStrings.color,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          size: 16,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Wrap(
                          children: List<Widget>.generate(
                            3,
                            (int index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: InkWell(
                                  onTap: () {
                                    cubit.changeColor(index);
                                  },
                                  child: CircleAvatar(
                                    radius: 14,
                                    backgroundColor: index == 0
                                        ? Colors.red
                                        : index == 1
                                            ? Colors.orange
                                            : AppColors.primaryColor,
                                    child: cubit.selectTaskColor == index
                                        ? Icon(
                                            Icons.done,
                                            color: Colors.white,
                                            size: 16,
                                          )
                                        : Container(),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomButton(
                    margin: EdgeInsets.all(30),
                    height: context.height * .07,
                    text: AppStrings.createTask,
                    color: AppColors.primaryColor,
                    press: () async {
                      if (formKey.currentState!.validate()) {
                        cubit.insertToDatabase(
                          title: titleController.text,
                          date: dateController.text,
                          startTime: startTimeController.text,
                          endTime: endTimeController.text,
                          remind: selectedRemind,
                          repeat: repeatController.text,
                          color: cubit.selectTaskColor,
                        );
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        );
                        navigateTo(
                          context,
                          HomeBoardScreen(),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
