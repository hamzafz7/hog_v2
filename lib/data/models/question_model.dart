import 'package:hog_v2/data/models/choice_model.dart';
import 'package:hog_v2/data/models/question_quiz.dart';

class QuestionModel {
  int? id;
  String? title;
  String? image;
  bool? imageExist;
  String? clarificationImage;
  bool? clarificationImageExist;
  String? clarificationText;
  List<ChoiceModel>? choices;
  QuestionQuiz? questionQuiz;
  QuestionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    imageExist = false;
    clarificationImageExist = false;
    clarificationImage = json['clarification_image'];
    clarificationText = json['clarification_text'];
    choices = json['choices'] != null
        ? List<ChoiceModel>.from(json['choices'].map((e) => ChoiceModel.fromJson(e)))
        : [];
    questionQuiz = QuestionQuiz.fromJson(json['questionQuiz']);
  }
}
