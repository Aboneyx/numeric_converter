import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logger/logger.dart';
import 'package:numeric_converter/core/converter_service.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ConverterService _converterService;
  List<String> _numbers = [];
  final List<String> _operations = [];
  List<String> _binNumbers = [];
  final Logger _logger = Logger();

  HomeBloc(this._converterService) : super(const InitialState()) {
    on<HomeEventCalculate>(_calculate);
    on<HomeEventClear>(_clear);
  }

  Future<void> _calculate(
    HomeEventCalculate event,
    Emitter<HomeState> emit,
  ) async {
    // emit(const LoadingState());
    _operations.clear();
    _numbers.clear();
    _binNumbers.clear();

    try {
      final String str = event.task.trim().replaceAll(" ", "");
      log(str);
      // сохраняю числа и опрейшн на массивы
      int lastIndex = 0;
      for (int i = 0; i < str.length; i++) {
        if (str[i] == '+' || str[i] == '-' || str[i] == '/' || str[i] == '*') {
          _operations.add(str[i]);
          if (str.substring(lastIndex, i) != '') {
            _numbers.add(str.substring(lastIndex, i));
            lastIndex = i + 1;
          }
        }
      }
      _numbers.add(str.substring(lastIndex, str.length));

      for (int i = 0; i < _numbers.length; i++) {
        if (_numbers[i].contains('0x') || _numbers[i].contains('0X')) {
          _binNumbers.add(_converterService.hexToBin(_numbers[i]));
        } else if (_numbers[i].contains('0b') || _numbers[i].contains('0B')) {
          _binNumbers.add(_numbers[i].substring(2));
        } else if (_numbers[i].contains('0o') || _numbers[i].contains('0O')) {
          _binNumbers.add(_converterService.octalToBin(_numbers[i]));
        } else {
          _binNumbers.add(_converterService.decToBin(_numbers[i]));
        }
      }

      // for (int i = 0; i < _binNumbers.length; i++) {
      //   log(_converterService.binToDecimal(_binNumbers[i]));
      // }

      int binAnswer = int.parse(_binNumbers[0], radix: 2);
      for (int i = 1; i < _binNumbers.length; i++) {
        int n1 = int.parse(_binNumbers[i], radix: 2);
        if (_operations[i - 1] == '+') {
          // _logger.d(
          //   _converterService.plus(
          //     binAnswer.toRadixString(2),
          //     n1.toRadixString(2),
          //   ),
          // );

          // binAnswer = //binAnswer +
          //     int.parse(
          //       _converterService.plus(
          //         binAnswer.toRadixString(2),
          //         n1.toRadixString(2),
          //       ),
          //       radix: 2,
          //     );

          binAnswer = binAnswer + n1;
        } else if (_operations[i - 1] == '-') {
          // _logger.d(
          //   _converterService.minus(
          //     binAnswer.toRadixString(2),
          //     n1.toRadixString(2),
          //   ),
          // );

          // binAnswer = //binAnswer +
          //     int.parse(
          //       _converterService.minus(
          //         binAnswer.toRadixString(2),
          //         n1.toRadixString(2),
          //       ),
          //       radix: 2,
          //     );

          binAnswer = binAnswer - n1;
        }
      }
      log("binAnswer: $binAnswer");

      _logger.d(_numbers);
      _logger.d(_binNumbers);
      _logger.d(_operations);

      emit(
        LoadedState(
          hexAns: _converterService.binToHex(binAnswer.toRadixString(2)),
          decAns: "$binAnswer",
          binaryAns: binAnswer.toRadixString(2),
          octalAns: _converterService.binToOctal(binAnswer.toRadixString(2)),
        ),
      );
    } catch (e) {
      log(e.toString());
      emit(const ErrorState(message: 'Something wrong :('));
    }
  }

  Future<void> _clear(
    HomeEventClear event,
    Emitter<HomeState> emit,
  ) async {
    emit(const LoadingState());
    await Future.delayed(const Duration(milliseconds: 1000));
    emit(const InitialState());
  }
}
