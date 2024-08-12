import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:messenger/core/widgets/my_form_field.dart';
import 'package:messenger/todo_app/layout/cubit/cubit.dart';
import 'package:messenger/todo_app/layout/cubit/state.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDataFromDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppInsertDataFromDatabaseState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Scaffold(
            key: cubit.scaffoldKey,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text(
                cubit.titles[cubit.currentIndex],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isShowBottom) {
                  cubit.insertDataFromDatabase(
                    title: cubit.titleController.text,
                    time: cubit.timeController.text,
                    date: cubit.dateController.text,
                  );
                  cubit.changeFabIcon(
                    isShow: false,
                    icon: Icons.edit,
                  );
                } else {
                  cubit.scaffoldKey.currentState!
                      .showBottomSheet(
                        (context) => Container(
                          color: Colors.grey[300],
                          child: Padding(
                            padding: const EdgeInsets.all(
                              20.0,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                MyFormField(
                                  controller: cubit.titleController,
                                  type: TextInputType.text,
                                  label: 'title',
                                  prefix: Icons.title,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Title must not be empty';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                MyFormField(
                                  controller: cubit.timeController,
                                  type: TextInputType.datetime,
                                  label: 'time',
                                  prefix: Icons.watch_later_outlined,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Time must not be empty';
                                    }
                                    return null;
                                  },
                                  onTap: () {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then(
                                      (value) {
                                        if (value != null) {
                                          if (context.mounted) {
                                            cubit.timeController.text =
                                                value.format(context);
                                            debugPrint(value.format(context));
                                          }
                                        }
                                      },
                                    );
                                  },
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                MyFormField(
                                  controller: cubit.dateController,
                                  type: TextInputType.datetime,
                                  label: 'date',
                                  prefix: Icons.calendar_today,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'date must not be empty';
                                    }
                                    return null;
                                  },
                                  onTap: () {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    showDatePicker(
                                      context: context,
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse(
                                        '2024-12-31',
                                      ),
                                    ).then(
                                      (value) {
                                        if (value != null) {
                                          cubit.dateController.text =
                                              DateFormat.yMMMd().format(value);
                                          debugPrint(
                                              DateFormat.yMMMd().format(value));
                                        }
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .closed
                      .then(
                    (value) {
                      cubit.changeFabIcon(
                        isShow: false,
                        icon: Icons.edit,
                      );
                    },
                  );
                  cubit.changeFabIcon(
                    isShow: true,
                    icon: Icons.add,
                  );
                }
              },
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  30.0,
                ),
              ),
              child: Icon(
                cubit.fabIcon,
                color: Colors.white,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: cubit.items,
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.grey,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNav(index);
              },
              type: BottomNavigationBarType.fixed,
            ),
            body: cubit.screens[cubit.currentIndex],
          );
        },
      ),
    );
  }
}
