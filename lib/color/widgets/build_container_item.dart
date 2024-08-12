import 'package:flutter/material.dart';
import 'package:messenger/color/cubit/cubit.dart';

class BuildContainerItem extends StatelessWidget {
  final int index;
  const BuildContainerItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150.0,
      decoration: BoxDecoration(
        color: ColorsCubit.get(context).taskColors[index],
        borderRadius: BorderRadius.circular(
          20.0,
        ),
      ),
    );
  }
}
