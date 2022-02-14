import 'dart:developer';

import 'package:logger/logger.dart';

class ConverterService {
  Logger _logger = Logger();
  final Map<int, String> _decHexMap = {
    0: "0",
    1: "1",
    2: "2",
    3: "3",
    4: "4",
    5: "5",
    6: "6",
    7: "7",
    8: "8",
    9: "9",
    10: "A",
    11: "B",
    12: "C",
    13: "D",
    14: "E",
    15: "F",
  };

  String plus(String firstBinary, String secondBinary) {
    log('String firstBinary, String secondBinary $firstBinary, $secondBinary');
    final List<String> firstArray =
        firstBinary.split('').reversed.join().split('');
    final List<String> secondArray =
        secondBinary.split('').reversed.join().split('');

    // print(firstArray.length.toString() + "  " + secondArray.length.toString());
    // print(secondArray.length - firstArray.length);
    //levels
    if (secondArray.length > firstArray.length) {
      int i = 0;
      while (i < secondBinary.length - firstBinary.length) {
        firstArray.add("0");
        // log('ascacs1 $i');
        i++;
      }
      // for (int j = 0; j <= secondArray.length - firstArray.length; j++) {
      //   firstArray.add("0");
      //   log('ascacs1 $j');
      // }
    } else if (secondArray.length < firstArray.length) {
      for (int i = 0; i < firstBinary.length - secondBinary.length; i++) {
        log('ascacs $i');

        secondArray.add("0");
      }
    }

    log("$firstBinary $firstArray");
    log("$secondBinary $secondArray");

    final List<String> list = [];
    final StringBuffer newStringBuilder = StringBuffer();
    int carry = 0;
    for (int i = 0; i < firstBinary.length; i++) {
      final int a =
          carry + int.parse(firstArray[i]) + int.parse(secondArray[i]);
      switch (a) {
        case 0:
          list.add("0");
          carry = 0;
          break;
        case 1:
          list.add("1");
          carry = 0;
          break;
        case 2:
          list.add("0");
          carry = 1;
          break;
        case 3:
          list.add("1");
          carry = 1;
          break;
      }
    }
    for (int i = list.length - 1; i >= 0; i--) {
      newStringBuilder.write(list[i]);
    }

    if (int.parse(firstArray[firstBinary.length - 1]) +
            int.parse(secondArray[secondBinary.length - 1]) >=
        1) {
      log('!!!!!!!!!!!!!!! 1$newStringBuilder');
      return "1$newStringBuilder";
    }
    log('!!!!!!!!!!!!!!!!!!!!!+ $newStringBuilder');
    return newStringBuilder.toString();
  }

  String minus(String firstBinary, String secondBinary) {
    final StringBuffer newStringBuffer = StringBuffer();

    final List<String> firstArray =
        firstBinary.split('').reversed.join().split('');
    final List<String> secondArray =
        secondBinary.split('').reversed.join().split('');

    if (secondArray.length > firstArray.length) {
      int i = 0;
      while (i < secondBinary.length - firstBinary.length) {
        firstArray.add("0");
        log('ascacs1 $i');
        i++;
      }
    } else if (secondArray.length < firstArray.length) {
      for (int i = 0; i < firstBinary.length - secondBinary.length; i++) {
        log('ascacs $i');

        secondArray.add("0");
      }
    }

    for (int i = 0; i < firstBinary.length; i++) {
      final int firstDigit = int.parse(firstArray[i]);
      final int secondDigit = int.parse(secondArray[i]);
      int a;

      if (firstDigit >= secondDigit) {
        a = firstDigit - secondDigit;
        newStringBuffer.write(a);
      } else {
        a = 2 + firstDigit - secondDigit;
        newStringBuffer.write(a);
        final int minussedNum = int.parse(firstArray[i + 1]) - 1;
        firstArray[i + 1] = minussedNum.toString();
      }
    }

    return newStringBuffer.toString().split('').reversed.join();
  }

  String hexToBin(String hex) {
    final StringBuffer bin = StringBuffer();
    for (int i = 2; i < hex.length; i++) {
      switch (hex[i]) {
        case '0':
          bin.write("0000");
          break;
        case '1':
          bin.write("0001");
          break;
        case '2':
          bin.write("0010");
          break;
        case '3':
          bin.write("0011");
          break;
        case '4':
          bin.write("0100");
          break;
        case '5':
          bin.write("0101");
          break;
        case '6':
          bin.write("0110");
          break;
        case '7':
          bin.write("0111");
          break;
        case '8':
          bin.write("1000");
          break;
        case '9':
          bin.write("1001");
          break;
        case 'A':
        case 'a':
          bin.write("1010");
          break;
        case 'B':
        case 'b':
          bin.write("1011");
          break;
        case 'C':
        case 'c':
          bin.write("1100");
          break;
        case 'D':
        case 'd':
          bin.write("1101");
          break;
        case 'E':
        case 'e':
          bin.write("1110");
          break;
        case 'F':
        case 'f':
          bin.write("1111");
          break;
        default:
      }
    }
    return bin.toString();
  }

  String binToHex(String bin) {
    final int decimal = int.parse(binToDecimal(bin));

    final StringBuffer buffer = StringBuffer();
    for (int i = decimal; i >= 1; i = i ~/ 16) {
      buffer.write(_decHexMap[i % 16]);
    }

    // log('${buffer.toString()} ,${buffer.toString().split('').join()}, $decimal, $bin');
    return buffer.toString().split('').reversed.join();
  }

  String octalToBin(String octal) {
    final StringBuffer bin = StringBuffer();

    for (int i = 2; i < octal.length; i++) {
      switch (octal[i]) {
        case '0':
          bin.write("000");
          break;
        case '1':
          bin.write("001");
          break;
        case '2':
          bin.write("010");
          break;
        case '3':
          bin.write("011");
          break;
        case '4':
          bin.write("100");
          break;
        case '5':
          bin.write("101");
          break;
        case '6':
          bin.write("110");
          break;
        case '7':
          bin.write("111");
          break;
        default:
      }
    }

    return bin.toString();
  }

  String binToOctal(String bin) {
    try {
      final int decimal = int.parse(binToDecimal(bin));
      final StringBuffer buffer = StringBuffer();

      for (int i = decimal; i >= 1; i ~/= 8) {
        buffer.write(i % 8);
      }

      return buffer.toString().split('').reversed.join();
    } catch (e) {
      log('message::: its not number, $e');
      throw Exception(e);
    }
  }

  String decToBin(String dec) {
    final StringBuffer bin = StringBuffer();
    try {
      int decInt = int.parse(dec);

      while (decInt > 0) {
        log(decInt.toString());
        bin.write(decInt % 2);
        decInt = decInt ~/ 2;
      }
      bin.write(decInt % 2);
      log('message');

      return bin.toString().split('').reversed.join();
    } catch (e) {
      log('message:::: its not number, $e');
      throw Exception(e);
    }
  }

  String binToDecimal(String bin) {
    try {
      int dec = 0;
      int base1 = 1;
      int num = int.parse(bin);

      while (num > 0) {
        final int lastDigit = num % 10;
        num = num ~/ 10;

        dec += lastDigit * base1;

        base1 = base1 * 2;
      }

      return dec.toString();
    } catch (e) {
      log('message:::: its not number, $e');
      throw Exception(e);
    }
  }

  // final Map<String, String> _binHexMap = {
  //   "0000": '0',
  //   "0001": '1',
  //   "0010": '2',
  //   "0011": '3',
  //   "0100": '4',
  //   "0101": '5',
  //   "0110": '6',
  //   "0111": '7',
  //   "1000": '8',
  //   "1001": '9',
  //   "1010": 'A',
  //   "1011": 'B',
  //   "1100": 'C',
  //   "1101": 'D',
  //   "1110": 'E',
  //   "1111": 'F',
  // };

  // final Map<String, String> _binOctalMap = {
  //   "000": '0',
  //   "001": '1',
  //   "010": '2',
  //   "011": '3',
  //   "100": '4',
  //   "101": '5',
  //   "110": '6',
  //   "111": '7',
  // };
}
