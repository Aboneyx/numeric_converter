import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.dart';
part 'home_cubit.freezed.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState.initialState());

  List<String>? strings = [];
  int count = 0;
  Future<void> changeArray() async {
    emit(HomeState.loadedState(strings: strings));

    count++;
    strings!.add('value $count');
  }
}
