import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hog_v2/common/constants/colors.dart';
import 'package:hog_v2/presentation/custom_dialogs/custom_dialogs.dart';
import 'package:hog_v2/presentation/custom_dialogs/time_elapsed_dialog.dart';
import 'package:hog_v2/presentation/quizzes/controllers/quiz_controller.dart';
import 'package:hog_v2/presentation/quizzes/pages/result_page.dart';
import 'package:hog_v2/presentation/quizzes/widgets/quiz_info_widget.dart';
import 'package:hog_v2/presentation/quizzes/widgets/result_button_widget.dart';
import 'package:hog_v2/presentation/quizzes/widgets/result_grade_Stack.dart';

class QuizStatisticPage extends GetView<QuizController> {
  const QuizStatisticPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          Get.back();
          controller.clearSolutions();
          return true;
        },
        child: SizedBox(
          height: Get.height,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                width: Get.width,
                height: 430.h,
                decoration: BoxDecoration(
                    color: kprimaryBlueColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25.r), bottomRight: Radius.circular(25.r))),
              ),
              Positioned(
                  top: 0,
                  right: 30,
                  left: 30,
                  bottom: 500.h,
                  child: ResultGradeStack(
                    res: controller.finalResults,
                  )),
              Positioned(
                  top: 320.h, bottom: 320.h, right: 30, left: 30, child: const QuizInfoWidget()),
              Positioned(
                bottom: 60.h,
                child: SizedBox(
                  width: Get.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ResultButtonWidget(
                            ontap: () {
                              Get.to(() => ResultPage(
                                    model: controller.model,
                                  ));
                            },
                            color: kShowReslutsColor,
                            svgURL: "assets/images/eye.svg",
                            text: "رؤية النتائج",
                          ),
                          SizedBox(
                            height: 60.h,
                          ),
                          ResultButtonWidget(
                              ontap: () {
                                customDialog(context,
                                    child: TimeElapsedDialog(timeElapsed: controller.timeElapsed));
                              },
                              color: ksecondaryColor,
                              svgURL: "assets/images/clock (1).svg",
                              text: "الوقت المستغرق")
                        ],
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 50.w,
                          ),

                          ResultButtonWidget(
                              ontap: () {
                                controller.clearSolutions();
                                Get.back();
                                // controller.refresh();
                              },
                              color: kprimaryPurpleColor,
                              svgURL: "assets/images/retry.svg",
                              text: "إعادة المحاولة"),

                          // const ResultButtonWidget(
                          //     color: Colors.red,
                          //     svgURL: "assets/images/eye.svg",
                          //     text: "رؤية النتائج")
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
