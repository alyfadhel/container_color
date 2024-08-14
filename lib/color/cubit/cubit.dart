import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/color/cubit/state.dart';


class ColorsCubit extends Cubit<ColorsStates>{

  ColorsCubit():super(ColorsInitialState());

  static ColorsCubit get(context)=>BlocProvider.of(context);

  List<Color>taskColors = [
    Colors.red,
    Colors.blue,
    Colors.pink,
    Colors.purple,
    Colors.orange,
    Colors.amber
  ];

  int selectCurrentIndex = 0;

  void changeColors(index){
    selectCurrentIndex = index;
    emit(ColorsChangedState());
  }
}