import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/ulits/app_string.dart';
import 'package:to_do_app/core/ulits/cubit/cubit.dart';
import 'package:to_do_app/core/ulits/cubit/states.dart';
import 'package:to_do_app/core/ulits/widget/navigate_widget.dart';
import 'package:to_do_app/presentation/schedule/schedule_screen.dart';

import '../../core/ulits/app_colors.dart';
import '../../core/ulits/widget/custom_text.dart';
import 'pages/all_task_screen.dart';
import 'pages/completed_screen.dart';
import 'pages/favourite_screen.dart';
import 'pages/uncompleted_screen.dart';

class HomeBoardScreen extends StatelessWidget {
  HomeBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return DefaultTabController(
          length: cubit.tabsScreens.length,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 2,
              title: Row(
                children: [
                  CustomText(
                    text: AppStrings.board,
                    color: AppColors.textBlack,
                    fontWeight: FontWeight.bold,
                    size: 20,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      navigateTo(
                        context,
                        ScheduleScreen(),
                      );
                    },
                    icon: const Icon(
                      Icons.calendar_month,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
              bottom: TabBar(
                isScrollable: true,
                indicatorColor: Colors.black,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(
                    child: CustomText(
                      text: AppStrings.all,
                      size: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Tab(
                    child: CustomText(
                      text: AppStrings.completed,
                      size: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Tab(
                    child: CustomText(
                      text: AppStrings.unCompleted,
                      size: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Tab(
                    child: CustomText(
                      text: AppStrings.favourite,
                      size: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                AllTasksScreen(),
                CompletedScreen(),
                UncompletedScreen(),
                FavouriteScreen(),
              ],
            ),
          ),
        );
      },
    );
  }
}
