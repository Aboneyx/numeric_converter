part of 'home_bloc.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.calculate({
    required String task,
  }) = HomeEventCalculate;
  const factory HomeEvent.clear() = HomeEventClear;
}
