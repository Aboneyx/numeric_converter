part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initialState() = InitialState;

  const factory HomeState.loadingState() = LoadingState;

  const factory HomeState.loadedState({
    List<String>? strings,
  }) = LoadedState;

  const factory HomeState.errorState({
    required String message,
    int? statusCode,
  }) = ErrorState;
}
