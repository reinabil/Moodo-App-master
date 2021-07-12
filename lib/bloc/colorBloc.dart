import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ColorEvent { green, pink }

class ColorBloc extends Bloc<ColorEvent, Color> {
  ColorBloc(Color initialState) : super(initialState);

  @override
  Stream<Color> mapEventToState(ColorEvent event) async* {
    yield (event == ColorEvent.pink) ? Colors.pink : Colors.green;
  }
}
