import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:hog_v2/common/constants/colors.dart';
import 'package:hog_v2/data/models/chapter_model.dart';
import 'package:hog_v2/data/providers/casheProvider/cashe_provider.dart';
import 'package:hog_v2/presentation/course_details/widgets/quiz_list_tile.dart';

import 'course_lesson_widget.dart';

class CustomListTile extends StatefulWidget {
  const CustomListTile({super.key, required this.chapterModel});

  final ChapterModel chapterModel;

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  late final List<Widget> list1, list2;

  @override
  void initState() {
    list1 = List.generate(
        widget.chapterModel.lessons!.length,
        (index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: CourseLessonWidget(lessionModel: widget.chapterModel.lessons![index]),
            ));
    list2 = List.generate(
        widget.chapterModel.quizzes!.length,
        (index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: QuizListTile(quizzModel: widget.chapterModel.quizzes![index]),
            ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: Card(
            color: GetIt.instance<CacheProvider>().getAppTheme() ? kprimaryBlueColor : null,
            surfaceTintColor:
                GetIt.instance<CacheProvider>().getAppTheme() ? kDarkBlueColor : Colors.white,
            shadowColor: Colors.grey,
            child: ExpansionTile(
                iconColor:
                    GetIt.instance<CacheProvider>().getAppTheme() ? Colors.white : kDarkBlueColor,
                collapsedIconColor:
                    GetIt.instance<CacheProvider>().getAppTheme() ? Colors.white : kDarkBlueColor,
                expandedAlignment: Alignment.topRight,
                backgroundColor:
                    GetIt.instance<CacheProvider>().getAppTheme() ? kDarkBlueColor : Colors.white,
                title: Text(
                  widget.chapterModel.name ?? "لا يوجد اسم لهذا الكورس",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16.sp),
                ),
                children: widget.chapterModel.lessons != null &&
                        widget.chapterModel.lessons!.isNotEmpty
                    ? list1 + list2
                    : [
                        const Padding(
                            padding: EdgeInsets.all(8.0), child: Text("لا يوجد دروس لهذا الفصل"))
                      ]),
          ),
        ),
      ),
    );
  }
}
