class ChoiceModel {
  int? id;
  String? title;
  String? image;
  bool? imageExist;
  int? questionId;
  bool? isTrue;
  bool? isVisible;
  ChoiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    imageExist = false;
    questionId = json['question_id'];
    isTrue = json['is_true'];
    isVisible = json['is_visible'];
  }
}
