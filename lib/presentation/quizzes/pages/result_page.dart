import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hog_v2/common/constants/colors.dart';
import 'package:hog_v2/data/models/quiz_model.dart';
import 'package:hog_v2/data/providers/casheProvider/cashe_provider.dart';
import 'package:hog_v2/presentation/quizzes/controllers/quiz_controller.dart';
import 'package:hog_v2/presentation/quizzes/widgets/quistion_result.dart';

class ResultPage extends GetView<QuizController> {
  const ResultPage({super.key, required this.model});

  final QuizzModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GetIt.instance<CacheProvider>().getAppTheme()
            ? const Color.fromARGB(255, 7, 37, 61)
            : null,
        surfaceTintColor:
            GetIt.instance<CacheProvider>().getAppTheme() ? kDarkBlueColor : Colors.white,
        title: Text(
          "نتائج ${model.title ?? " "} ",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: controller.model.questions!.length,
          itemBuilder: (context, index) => QuestionResultWidget(
                isTrue: controller.rightSolutions[model.questions![index].id] ==
                    controller.userSolutions[model.questions![index].id],
                index: index,
                model: controller.model.questions![index],
              )),
    );
  }
}
