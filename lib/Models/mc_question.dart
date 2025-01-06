class MultipleChoiceQuestion {
  final List<dynamic> answers;
  final int leitnerWeight;
  final int lesson;
  final String questionText;

  MultipleChoiceQuestion({ required this.questionText, required this.answers, required this.lesson, required this.leitnerWeight});
}