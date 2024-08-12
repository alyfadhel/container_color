import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/color/cubit/cubit.dart';
import 'package:messenger/color/cubit/state.dart';

class ColorScreen extends StatelessWidget {
  const ColorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ColorsCubit(),
      child: BlocConsumer<ColorsCubit, ColorsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ColorsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Colors',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(
                20.0,
              ),
              child: Column(
                children: [
                  buildContainerItem(cubit.selectCurrentIndex, context),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      ...cubit.taskColors
                          .asMap()
                          .map(
                            (key, value) => MapEntry(
                              key,
                              IconButton(
                                onPressed: () {
                                  cubit.changeColors(key);
                                },
                                icon: Container(
                                  width: 40.0,
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: cubit.selectCurrentIndex == key
                                          ? Colors.green
                                          : Colors.transparent,
                                      width: 3.0,
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(2.0),
                                  child: Container(
                                    width: 40.0,
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: value,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .values,
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
Widget buildContainerItem(index, context)=>Container(
  width: double.infinity,
  height: 150.0,
  decoration: BoxDecoration(
    color: ColorsCubit.get(context).taskColors[index],
    borderRadius: BorderRadius.circular(
      20.0,
    ),
  ),
);