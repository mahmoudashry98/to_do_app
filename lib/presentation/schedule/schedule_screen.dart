import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/core/ulits/cubit/cubit.dart';
import 'package:to_do_app/core/ulits/cubit/states.dart';
import 'package:to_do_app/services/local_notification/local_notification.dart';

class ScheduleScreen extends StatefulWidget {
  ScheduleScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  var notifyHelper;
  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
  }

  DateTime dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              'Schedule',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            elevation: 1,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DatePicker(
                  DateTime.now(),
                  initialSelectedDate: DateTime.now(),
                  selectionColor: Colors.green,
                  selectedTextColor: Colors.white,
                  daysCount: 7,
                  height: 90,
                  onDateChange: (date) {
                    setState(() {
                      dateTime = date;
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 1,
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Text(
                      '${DateFormat('EEEE').format(dateTime)}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                       
                      DateTime date = DateFormat.jm().parse(
                        cubit.tasks[0]['startTime'].toString(),
                      );
                      var myTime = DateFormat('HH:mm').format(date);
                      notifyHelper.scheduledNotification(
                        int.parse(myTime.toString().split(":")[0]),
                        int.parse(myTime.toString().split(":")[1]),
                        cubit.tasks,
                      );
                      },
                      child: Text(
                        '${DateFormat('d MMM, y').format(dateTime)}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                      height: 10,
                    ),
                    itemCount: cubit.tasks.length,
                    itemBuilder: (context, index) {
                      var model = cubit.tasks[index];
                      DateTime date = DateFormat.jm().parse(
                        cubit.tasks[index]['startTime'].toString(),
                      );
                      var myTime = DateFormat('HH:mm').format(date);
                      notifyHelper.scheduledNotification(
                        int.parse(myTime.toString().split(":")[0]),
                        int.parse(myTime.toString().split(":")[1]),
                        cubit.tasks,
                      );

                      if (model['repeat'] == 'Daily') {
                        return buildTaskItem(
                          context,
                          model,
                          index,
                        );
                      }
                      if (model['date'] == DateFormat.yMd().format(dateTime)) {
                        return buildTaskItem(
                          context,
                          model,
                          index,
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget buildTaskItem(
  context,
  data,
  int index,
) {
  var cubit = AppCubit.get(context);
  var model = cubit.tasks[index];
  return Dismissible(
    key: Key(model['id'].toString()),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: model['color'] == 0
            ? Colors.red
            : index == 1
                ? Colors.orange
                : Colors.green,
      ),
      height: 85,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 15,
              left: 25,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model['startTime']}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '${model['title']}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: model['status'] == 'complete'
                ? Icon(
                    Icons.check_circle_outline,
                    color: Colors.grey[400],
                    size: 30,
                  )
                : Icon(
                    Icons.circle_outlined,
                    color: Colors.grey[400],
                    size: 30,
                  ),
          ),
        ],
      ),
    ),
    onDismissed: (direction) {
      cubit.deleteData(id: data['id']);
    },
  );
}
