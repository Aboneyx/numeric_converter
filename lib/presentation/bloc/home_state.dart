part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initialState() = InitialState;

  const factory HomeState.loadingState() = LoadingState;

  const factory HomeState.loadedState({
    required String hexAns,
    required String decAns,
    required String binaryAns,
    required String octalAns,
  }) = LoadedState;

  const factory HomeState.errorState({
    required String message,
    int? statusCode,
  }) = ErrorState;
}
