import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class FavBloc extends Bloc<int, List<int>> {
  FavBloc(List<int> initialState) : super(initialState);

  List<int> get fav => fav;

  @override
  Stream<List<int>> mapEventToState(int event) async* {
    List<int> fav = [0];
    for (var i = 0; i < fav.length; i++) {
      fav.add(event);
    }
    yield fav;
  }
}
