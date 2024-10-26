import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hog_v2/data/models/quiz_model.dart';

class QuizController extends GetxController {
  late QuizzModel model;
  int _totalTimeInSeconds = 3600;
  double initalValue = (1 / 3);
  late int totalQuistions;
  int currentQuistions = 1;
  double finalResults = 0.0;

  @override
  void onInit() {
    model = Get.arguments;
    totalQuistions = model.questions?.length ?? 1;
    initalValue = (1 / totalQuistions);
    startCountdown();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    formattedTime.close();
  }

  Rx<String> get formattedTime =>
      "${(_totalTimeInSeconds ~/ 60).toString().padLeft(2, '0')}:${(_totalTimeInSeconds % 60).toString().padLeft(2, '0')}"
          .obs;

  late Timer timer;

  void startCountdown() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_totalTimeInSeconds > 0) {
        _totalTimeInSeconds--;
      } else {
        timer.cancel();
      }
    });
  }

  PageController pageController = PageController();
  int currentIndex = 0;

  incrementQuistionsValue() {
    if (currentQuistions < totalQuistions) {
      initalValue = initalValue + 1 / totalQuistions;
      currentQuistions++;
      currentIndex++;
    }
    update();
  }

  decrementQuistionsValue() {
    if (currentQuistions > 1) {
      initalValue = initalValue - 1 / totalQuistions;
      currentQuistions--;
      currentIndex--;
    }
    update();
  }

  Map<int, int> userSolutions = {};
  Map<int, int> rightSolutions = {};
  int skippedQuistions = 0;
  int wrongAnswers = 0;
  int timeElapsed = 0;

  calcResult() {
    timer.cancel();
    timeElapsed = (timer.tick / 60).ceil();
    finalResults = 0.0;
    skippedQuistions = 0;
    wrongAnswers = 0;
    for (var element in model.questions!) {
      int ind = 0;
      for (int i = 0; i < element.choices!.length; i++) {
        if (element.choices![i].isTrue!) {
          ind = element.choices![i].id!;
          rightSolutions[element.id!] = element.choices![i].id!;
          break;
        }
      }
      if (userSolutions.containsKey(element.id) && userSolutions.containsValue(ind)) {
        finalResults += 1 / totalQuistions;
      } else if (userSolutions.containsKey(element.id) && !userSolutions.containsValue(ind)) {
        wrongAnswers += 1;
      } else if (!userSolutions.containsKey(element.id)) {
        skippedQuistions += 1;
      }
    }
  }

  provideSolution(int key, int val) {
    userSolutions[key] = val;
    update();
  }

  clearSolutions() {
    _totalTimeInSeconds = 3600;
    timeElapsed = 0;
    startCountdown();
    currentIndex = 0;
    currentQuistions = 1;
    initalValue = 1 / totalQuistions;
    userSolutions = {};
    pageController.jumpToPage(0);
    update();
  }
}
