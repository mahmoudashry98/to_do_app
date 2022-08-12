import 'package:flutter/material.dart';
import 'package:to_do_app/core/ulits/app_colors.dart';
import 'package:to_do_app/core/ulits/assets_images_path.dart';
import 'package:to_do_app/core/ulits/cubit/cubit.dart';

import '../../../core/ulits/app_string.dart';
import '../../../core/ulits/widget/custom_button.dart';
import '../../../core/ulits/widget/custom_text.dart';
import '../../../core/ulits/widget/navigate_widget.dart';
import '../../add_task/add_task_screen.dart';

Widget taskBuilder({
  required List<Map> tasks,
  context,
}) {
  var cubit = AppCubit.get(context);
  return cubit.tasks.length != 0
      ? Column(
          children: [
            Expanded(
              flex: 9,
              child: Container(
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) => buildTaskItem(
                    context,
                    tasks[index],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: CustomButton(
                margin: EdgeInsets.only(
                  bottom: 20,
                  left: 40,
                  right: 20,
                ),
                text: AppStrings.addTask,
                color: Colors.green,
                press: () {
                  navigateTo(
                    context,
                    AddTaskScreen(),
                  );
                },
              ),
            ),
          ],
        )
      : Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(
              image: AssetImage(
                addTaskImage,
              ),
            ),
            CustomText(
              text: AppStrings.noTasks,
              size: 16,
              color: Colors.grey,
            ),
            CustomButton(
              margin: EdgeInsets.only(
                bottom: 20,
                left: 40,
                right: 20,
              ),
            height: 50,
              text: AppStrings.addTask,
              color: Colors.green,
              press: () {
                navigateTo(
                  context,
                  AddTaskScreen(),
                );
              },
            ),
          ],
        );
}

Widget buildTaskItem(context, Map model) {
  var cubit = AppCubit.get(context);
  return InkWell(
    onTap: () {
      showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            insetPadding: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: Colors.white,
            contentPadding: const EdgeInsets.all(20),
            children: [
              CustomText(
                text: '${model['${AppStrings.titleDB}']}',
                size: 18,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.watch_later_outlined,
                    size: 30,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CustomText(
                    text: '${model['${AppStrings.startTime}']} -',
                  ),
                  CustomText(
                    text: '${model['${AppStrings.endTime}']}',
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  CustomButton(
                    padding: EdgeInsets.all(10),
                    text: AppStrings.completed,
                    color: Colors.green,
                    press: () {
                      cubit.updateData(
                        status: AppStrings.complete,
                        id: model['${AppStrings.id}'],
                      );
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CustomButton(
                    padding: EdgeInsets.all(10),
                    text: AppStrings.unCompleted,
                    color: Colors.green,
                    press: () {
                      cubit.updateData(
                        status: AppStrings.unComplete,
                        id: model['${AppStrings.id}'],
                      );
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CustomButton(
                    padding: EdgeInsets.all(10),
                    text: model['${AppStrings.favourite}'] == 'isFavourite'
                        ? 'UnFavourite'
                        : 'Favourite',
                    color: Colors.green,
                    press: () {
                      if (model['${AppStrings.favourite}'] == 'isFavourite') {
                        cubit.updateFavData(
                          favourite: '${AppStrings.unfavourite}',
                          id: model['${AppStrings.id}'],
                        );
                      } else {
                        cubit.updateFavData(
                          favourite: 'isFavourite',
                          id: model['${AppStrings.id}'],
                        );
                      }
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          );
        },
      );
    },
    child: Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 25,
                width: 27,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: model['${AppStrings.color}'] == cubit.selectTaskColor
                        ? Colors.red
                        : cubit.selectTaskColor == 1
                            ? Colors.orange
                            : Colors.green,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  color: model['${AppStrings.status}'] == AppStrings.complete
                      ? model['${AppStrings.color}'] == cubit.selectTaskColor
                          ? Colors.red
                          : cubit.selectTaskColor == 1
                              ? Colors.orange
                              : Colors.green
                      : Colors.white,
                ),
                child: Icon(
                  Icons.done_rounded,
                  size: 20,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              CustomText(
                text: '${model['${AppStrings.titleDB}']}',
                color: AppColors.textBlack,
                size: 18,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
