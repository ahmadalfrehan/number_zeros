import 'dart:developer' as dev;
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ControllerGame extends GetxController {
  final firstNumber = 1.obs;
  final secondNumber = 1.obs;
  final thirdNumber = 2.obs;
  final fourthNumber = 1.obs;
  final fifthNumber = 5.obs;
  RxList<int> list = <int>[].obs;

  generateRandom() {
    int length = Random().nextInt(9);
    dev.log(length.toString());
    for (var i = 0; i < length; ++i) {
      list.add(Random().nextInt(9));
    }
    dev.log(list.toString());
  }

  var twoDList = List.generate(3, (i) => List.generate(3, (j) => j.toString()));

  inital() {
    twoDList[0] = ['0', '1', '0'];
    twoDList[1] = ['1', '2', '1'];
    twoDList[2] = ['0', '5', '0'];
  }

  final focus1 = FocusNode();
  final focus2 = FocusNode();
  final focus3 = FocusNode();
  final focus4 = FocusNode();
  final focus5 = FocusNode();
  final focus6 = FocusNode();
  int? x1;
  int? x2;
  int? y1;
  int? y2;
  bool win = false;

  canMove(x1, y1, x2, y2) {
    if ((x2 == x1 + 1 && y2 == y1) ||
        (x2 == x1 - 1 && y2 == y1) ||
        (y2 == y1 + 1 && x2 == x1) ||
        (y2 == y1 - 1 && x2 == x1)) {
      return true;
    } else {
      return false;
    }
  }

  void move(int x1, int y1, int x2, int y2) {
    dev.log("");
    if ((x2 == x1 + 1 && y2 == y1) ||
        (x2 == x1 - 1 && y2 == y1) ||
        (y2 == y1 + 1 && x2 == x1) ||
        (y2 == y1 - 1 && x2 == x1)) {
      if (twoDList[x1][y1] == twoDList[x2][y2]) {
        twoDList[x1][y1] = twoDList[x2][y2] = 0 as String;
      } else {
        twoDList[x2][y2] += twoDList[x1][y1];
        twoDList[x1][y1] = '0';
      }
    }
    //  display();
  }

  void display() {
    dev.log("|$twoDList");
    for (int i = 0; i < twoDList.length; i++) {
      for (int j = 0; j < twoDList[i].length; j++) {
        if (twoDList[i][j] == '0') {
          win = true;
        } else {
          win = false;
        }
      }
      dev.log("|\n");
    }
  }

  isThePlayerWin() {
    for (int i = 0; i < twoDList.length; i++) {
      for (int j = 0; j < twoDList[i].length; j++) {
        if (twoDList[i][j] == '0') {
          win = true;
        } else {
          win = false;
        }
      }
    }
    if (win == true) {
      dev.log("you win");
    }
    return win;
  }

  @override
  void onInit() {
    generateRandom();
    inital();
    super.onInit();
  }
}
