import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountBloc extends Bloc<int, int> {
  CountBloc(int initialState) : super(initialState);

  @override
  Stream<int> mapEventToState(int event) async* {
    yield event;
  }
}
